# Portfolio Contact Form Backend API

A lightweight Go REST API for handling contact form submissions and sending emails via Gmail SMTP.

## Features

✅ **REST API** - Simple POST endpoint for contact form submissions  
✅ **Email Validation** - Validates name, email format, and message  
✅ **Gmail SMTP** - Sends emails using Gmail App Password  
✅ **CORS Support** - Works with Flutter web and localhost  
✅ **Environment Variables** - Secure credential management  
✅ **HTML Emails** - Beautiful formatted email templates  
✅ **Error Handling** - Proper HTTP status codes and JSON responses

## Prerequisites

- Go 1.21 or higher
- Gmail account with App Password enabled
- Git (optional)

## Setup Instructions

### 1. Navigate to Backend Directory

```bash
cd backend
```

### 2. Install Dependencies

```bash
go mod download
```

This will download the `godotenv` package for environment variable management.

### 3. Create Environment File

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` and add your Gmail credentials:

```env
GMAIL_EMAIL=your-email@gmail.com
GMAIL_APP_PASSWORD=your-16-char-app-password
PORT=8080
```

### 4. Generate Gmail App Password

1. Go to your Google Account: https://myaccount.google.com/
2. Navigate to **Security** → **2-Step Verification** (enable if not already)
3. Scroll to **App passwords**
4. Select "Mail" and generate a password
5. Copy the 16-character password to your `.env` file

### 5. Run the Server

```bash
go run main.go
```

The server will start on `http://localhost:8080`

You should see:
```
Email backend API starting...
Using Gmail account: you***@gmail.com
Server running on http://localhost:8080
```

## API Endpoints

### POST /api/contact

Send a contact form submission.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "subject": "Project Inquiry",
  "message": "I would like to discuss a project with you."
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Email sent successfully"
}
```

**Error Response (400):**
```json
{
  "success": false,
  "message": "email is required"
}
```

**Error Response (500):**
```json
{
  "success": false,
  "message": "Failed to send email"
}
```

### GET /health

Check if the API is running.

**Response (200):**
```json
{
  "success": true,
  "message": "API is healthy"
}
```

## Validation Rules

- **name**: Required, minimum 3 characters
- **email**: Required, valid email format
- **message**: Required, minimum 10 characters
- **subject**: Optional (defaults to "Portfolio Contact from [Name]")

## Testing

### Using curl

**Test the health endpoint:**
```bash
curl http://localhost:8080/health
```

**Send a test contact form:**
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "subject": "Test Message",
    "message": "This is a test message from the contact form API."
  }'
```

**Test validation (missing email):**
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "message": "This should fail"
  }'
```

**Test validation (invalid email):**
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "invalid-email",
    "message": "This should fail due to invalid email"
  }'
```

### Using Postman

1. Create a new POST request to `http://localhost:8080/api/contact`
2. Set Headers: `Content-Type: application/json`
3. Set Body (raw JSON):
```json
{
  "name": "Your Name",
  "email": "your@email.com",
  "subject": "Test Subject",
  "message": "Your test message here"
}
```
4. Send the request

## Integration with Flutter

Update your Flutter contact form to call this API:

```dart
Future<void> _sendEmail() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/contact'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'subject': 'Portfolio Contact',
        'message': _messageController.text.trim(),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    } else {
      throw Exception('Failed to send message');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}
```

Don't forget to add the `http` package to your `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
```

## Project Structure

```
backend/
├── main.go           # Main API implementation
├── go.mod            # Go module dependencies
├── .env              # Environment variables (not in git)
├── .env.example      # Example environment file
├── .gitignore        # Git ignore rules
└── README.md         # This file
```

## Security Notes

⚠️ **Important Security Practices:**

1. **Never commit `.env` file** - It's in `.gitignore` for a reason
2. **Never hardcode credentials** - Always use environment variables
3. **Use App Password** - Never use your actual Gmail password
4. **HTTPS in Production** - Use HTTPS when deploying to production
5. **Rate Limiting** - Consider adding rate limiting for production use

## Deployment

For production deployment, consider:

1. **Use a reverse proxy** (nginx, Caddy) with HTTPS
2. **Set environment variables** on your hosting platform
3. **Update CORS settings** to allow only your domain
4. **Add rate limiting** to prevent abuse
5. **Use a process manager** (systemd, PM2) to keep the server running

## Troubleshooting

**Error: "GMAIL_EMAIL and GMAIL_APP_PASSWORD must be set"**
- Make sure you created the `.env` file
- Check that the environment variables are set correctly

**Error: "Failed to send email"**
- Verify your Gmail App Password is correct
- Check that 2-Step Verification is enabled on your Google account
- Ensure you're using an App Password, not your regular password

**CORS errors in Flutter**
- The API already has CORS enabled for all origins (`*`)
- For production, update the CORS settings to allow only your domain

## License

MIT License - Feel free to use this in your projects!
