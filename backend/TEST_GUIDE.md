# Quick Test Guide

## Test Commands

### 1. Health Check
```bash
curl http://localhost:8080/health
```

**Expected Response:**
```json
{"success":true,"message":"API is healthy"}
```

---

### 2. Valid Contact Form Submission
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "subject": "Project Inquiry",
    "message": "I would like to discuss a potential project with you."
  }'
```

**Expected Response:**
```json
{"success":true,"message":"Email sent successfully"}
```

---

### 3. Test Validation - Missing Name
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "message": "This should fail"
  }'
```

**Expected Response:**
```json
{"success":false,"message":"name is required"}
```

---

### 4. Test Validation - Invalid Email
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "not-an-email",
    "message": "This should fail"
  }'
```

**Expected Response:**
```json
{"success":false,"message":"invalid email format"}
```

---

### 5. Test Validation - Short Message
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "message": "Short"
  }'
```

**Expected Response:**
```json
{"success":false,"message":"message must be at least 10 characters"}
```

---

### 6. Test Without Subject (Should Use Default)
```bash
curl -X POST http://localhost:8080/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Smith",
    "email": "jane@example.com",
    "message": "Testing without a subject line. Should use default subject."
  }'
```

**Expected Response:**
```json
{"success":true,"message":"Email sent successfully"}
```

**Email Subject:** "Portfolio Contact from Jane Smith"

---

## PowerShell Commands (Windows)

If you're using PowerShell, use these commands instead:

### Health Check
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/health" -Method Get
```

### Valid Contact Form
```powershell
$body = @{
    name = "John Doe"
    email = "john@example.com"
    subject = "Project Inquiry"
    message = "I would like to discuss a potential project with you."
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/contact" -Method Post -Body $body -ContentType "application/json"
```

---

## Expected Email Format

When a valid contact form is submitted, you'll receive an HTML email like this:

**Subject:** Portfolio Contact from [Name] (or custom subject)

**Body:**
```
┌─────────────────────────────────────┐
│ New Portfolio Contact Message       │
├─────────────────────────────────────┤
│ From: John Doe                      │
│ Email: john@example.com             │
│ Subject: Project Inquiry            │
│ Message:                            │
│ ┌─────────────────────────────────┐ │
│ │ I would like to discuss a       │ │
│ │ potential project with you.     │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

The email will be formatted with:
- Blue header
- Clean, professional layout
- Clickable email address
- Properly formatted message with line breaks preserved
