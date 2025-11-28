package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"net/smtp"
	"os"
	"regexp"
	"strings"

	"github.com/joho/godotenv"
)

// ContactRequest represents the incoming contact form data
type ContactRequest struct {
	Name    string `json:"name"`
	Email   string `json:"email"`
	Subject string `json:"subject"`
	Message string `json:"message"`
}

// Response represents the API response
type Response struct {
	Success bool   `json:"success"`
	Message string `json:"message"`
}

// Email configuration
var (
	gmailEmail    string
	gmailPassword string
	smtpHost      = "smtp.gmail.com"
	smtpPort      = "587"
)

func main() {
	// Load environment variables from .env file
	if err := godotenv.Load(); err != nil {
		log.Println("Warning: .env file not found, using system environment variables")
	}

	// Get Gmail credentials from environment
	gmailEmail = os.Getenv("GMAIL_EMAIL")
	gmailPassword = os.Getenv("GMAIL_APP_PASSWORD")

	if gmailEmail == "" || gmailPassword == "" {
		log.Fatal("Error: GMAIL_EMAIL and GMAIL_APP_PASSWORD must be set in environment variables")
	}

	// Remove spaces from app password (common issue)
	gmailPassword = strings.ReplaceAll(gmailPassword, " ", "")

	log.Println("Email backend API starting...")
	log.Printf("Using Gmail account: %s", maskEmail(gmailEmail))
	log.Printf("App password length: %d characters", len(gmailPassword))

	// Setup routes
	http.HandleFunc("/api/contact", corsMiddleware(handleContact))
	http.HandleFunc("/health", corsMiddleware(handleHealth))

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8910"
	}

	log.Printf("Server running on http://localhost:%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

// handleContact handles the POST /api/contact endpoint
func handleContact(w http.ResponseWriter, r *http.Request) {
	log.Printf("Received %s request to /api/contact", r.Method)

	// Only allow POST requests
	if r.Method != http.MethodPost {
		log.Printf("Method not allowed: %s", r.Method)
		sendJSONResponse(w, http.StatusMethodNotAllowed, Response{
			Success: false,
			Message: "Method not allowed",
		})
		return
	}

	// Parse request body
	var req ContactRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		log.Printf("Failed to decode JSON body: %v", err)
		sendJSONResponse(w, http.StatusBadRequest, Response{
			Success: false,
			Message: "Invalid request body: " + err.Error(),
		})
		return
	}

	log.Printf("Received contact request from: %s <%s>", req.Name, maskEmail(req.Email))

	// Validate request
	if err := validateContactRequest(&req); err != nil {
		log.Printf("Validation failed: %v", err)
		sendJSONResponse(w, http.StatusBadRequest, Response{
			Success: false,
			Message: err.Error(),
		})
		return
	}

	// Send email
	if err := sendEmail(&req); err != nil {
		log.Printf("SMTP Error: %v", err)
		sendJSONResponse(w, http.StatusInternalServerError, Response{
			Success: false,
			Message: "Failed to send email. Please try again later.",
		})
		return
	}

	// Success response
	log.Printf("Email sent successfully from: %s", maskEmail(req.Email))
	sendJSONResponse(w, http.StatusOK, Response{
		Success: true,
		Message: "Email sent successfully",
	})
}

// handleHealth handles the GET /health endpoint
func handleHealth(w http.ResponseWriter, r *http.Request) {
	sendJSONResponse(w, http.StatusOK, Response{
		Success: true,
		Message: "API is healthy",
	})
}

// validateContactRequest validates the contact form data
func validateContactRequest(req *ContactRequest) error {
	// Trim whitespace
	req.Name = strings.TrimSpace(req.Name)
	req.Email = strings.TrimSpace(req.Email)
	req.Subject = strings.TrimSpace(req.Subject)
	req.Message = strings.TrimSpace(req.Message)

	// Validate required fields
	if req.Name == "" {
		return fmt.Errorf("name is required")
	}
	if req.Email == "" {
		return fmt.Errorf("email is required")
	}
	if req.Message == "" {
		return fmt.Errorf("message is required")
	}

	// Validate name length
	if len(req.Name) < 3 {
		return fmt.Errorf("name must be at least 3 characters")
	}

	// Validate email format
	emailRegex := regexp.MustCompile(`^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$`)
	if !emailRegex.MatchString(req.Email) {
		return fmt.Errorf("invalid email format")
	}

	// Validate message length
	if len(req.Message) < 10 {
		return fmt.Errorf("message must be at least 10 characters")
	}

	return nil
}

// sendEmail sends an email using Gmail SMTP
func sendEmail(req *ContactRequest) error {
	// Set default subject if empty
	subject := req.Subject
	if subject == "" {
		subject = fmt.Sprintf("Portfolio Contact from %s", req.Name)
	}

	log.Printf("Preparing to send email with subject: %s", subject)

	// Compose email
	from := gmailEmail
	to := []string{gmailEmail}

	// Email headers and body
	message := []byte(
		"From: " + from + "\r\n" +
			"To: " + gmailEmail + "\r\n" +
			"Subject: " + subject + "\r\n" +
			"MIME-Version: 1.0\r\n" +
			"Content-Type: text/html; charset=UTF-8\r\n" +
			"\r\n" +
			formatEmailBody(req),
	)

	// SMTP authentication
	log.Printf("Authenticating with SMTP server: %s:%s", smtpHost, smtpPort)
	auth := smtp.PlainAuth("", gmailEmail, gmailPassword, smtpHost)

	// Send email
	addr := smtpHost + ":" + smtpPort
	log.Printf("Sending email to: %s", gmailEmail)

	if err := smtp.SendMail(addr, auth, from, to, message); err != nil {
		log.Printf("SMTP SendMail failed: %v", err)
		return fmt.Errorf("SMTP error: %w", err)
	}

	log.Println("Email sent successfully via SMTP")
	return nil
}

// formatEmailBody creates an HTML formatted email body
func formatEmailBody(req *ContactRequest) string {
	// Use default subject if empty
	subject := req.Subject
	if subject == "" {
		subject = fmt.Sprintf("Portfolio Contact from %s", req.Name)
	}

	return fmt.Sprintf(`
<!DOCTYPE html>
<html>
<head>
	<style>
		body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
		.container { max-width: 600px; margin: 0 auto; padding: 20px; }
		.header { background-color: #0ea5e9; color: white; padding: 20px; border-radius: 8px 8px 0 0; }
		.content { background-color: #f9fafb; padding: 20px; border-radius: 0 0 8px 8px; }
		.field { margin-bottom: 15px; }
		.label { font-weight: bold; color: #0ea5e9; }
		.value { margin-top: 5px; }
		.message-box { background-color: white; padding: 15px; border-left: 4px solid #0ea5e9; margin-top: 10px; white-space: pre-wrap; }
	</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<h2>New Portfolio Contact Message</h2>
		</div>
		<div class="content">
			<div class="field">
				<div class="label">From:</div>
				<div class="value">%s</div>
			</div>
			<div class="field">
				<div class="label">Email:</div>
				<div class="value"><a href="mailto:%s">%s</a></div>
			</div>
			<div class="field">
				<div class="label">Subject:</div>
				<div class="value">%s</div>
			</div>
			<div class="field">
				<div class="label">Message:</div>
				<div class="message-box">%s</div>
			</div>
		</div>
	</div>
</body>
</html>
	`, req.Name, req.Email, req.Email, subject, req.Message)
}

// corsMiddleware adds CORS headers to responses
func corsMiddleware(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Set CORS headers
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		// Handle preflight requests
		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusOK)
			return
		}

		next(w, r)
	}
}

// sendJSONResponse sends a JSON response
func sendJSONResponse(w http.ResponseWriter, statusCode int, response Response) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	json.NewEncoder(w).Encode(response)
}

// maskEmail masks the email address for logging (shows only first 3 chars and domain)
func maskEmail(email string) string {
	parts := strings.Split(email, "@")
	if len(parts) != 2 {
		return "***"
	}
	if len(parts[0]) <= 3 {
		return "***@" + parts[1]
	}
	return parts[0][:3] + "***@" + parts[1]
}
