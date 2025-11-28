# Go Backend 500 Error - Debugging Guide

## Common Causes of 500 Internal Server Error

### Issue #1: Gmail App Password with Spaces ⚠️

**Problem:**
When you copy the Gmail App Password from Google, it often includes spaces for readability:
```
dusd kevo kubn urel
```

**Why it causes 500:**
Gmail SMTP rejects authentication with spaces in the password, causing `smtp.SendMail()` to fail.

**Fix Applied (Line 50):**
```go
// Remove spaces from app password (common issue)
gmailPassword = strings.ReplaceAll(gmailPassword, " ", "")
```

---

### Issue #2: Missing Error Logging

**Problem:**
The original code logged errors but didn't provide enough detail to debug SMTP issues.

**Fixes Applied:**
1. **Line 54:** Log app password length to verify it's loaded correctly
2. **Line 76:** Log incoming request method
3. **Line 93:** Log decoded request data
4. **Line 110:** Log detailed SMTP errors
5. **Line 191:** Log SMTP connection details
6. **Line 198:** Log SMTP SendMail failures with full error

**Example Enhanced Logging:**
```go
log.Printf("SMTP Error: %v", err)  // Shows exact SMTP error
log.Printf("App password length: %d characters", len(gmailPassword))
log.Printf("Authenticating with SMTP server: %s:%s", smtpHost, smtpPort)
```

---

### Issue #3: Subject Parameter in Email Body

**Problem:**
The `formatEmailBody()` function was using `req.Subject` directly, which could be empty.

**Fix Applied (Lines 229-233):**
```go
// Use default subject if empty
subject := req.Subject
if subject == "" {
    subject = fmt.Sprintf("Portfolio Contact from %s", req.Name)
}
```

Now the email body always has a subject, even if not provided in the request.

---

## Testing the Fixes

### 1. Restart the Server

Stop the current server (Ctrl+C) and restart:
```bash
cd e:\mission\portfolio\backend
go run main.go
```

**Expected Output:**
```
Email backend API starting...
Using Gmail account: kud***@gmail.com
App password length: 16 characters
Server running on http://localhost:8910
```

⚠️ **If app password length is NOT 16:** Your password has spaces or is incorrect.

---

### 2. Test with curl

```bash
curl -X POST http://localhost:8910/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "message": "This is a test message to verify the fix."
  }'
```

**Expected Response (200 OK):**
```json
{
  "success": true,
  "message": "Email sent successfully"
}
```

**Expected Console Logs:**
```
Received POST request to /api/contact
Received contact request from: Test User <tes***@example.com>
Preparing to send email with subject: Portfolio Contact from Test User
Authenticating with SMTP server: smtp.gmail.com:587
Sending email to: kudhar892@gmail.com
Email sent successfully via SMTP
Email sent successfully from: tes***@example.com
```

---

### 3. Common Error Messages

#### Error: "535 Authentication failed"
```
SMTP Error: 535 5.7.8 Username and Password not accepted
```

**Causes:**
- App Password has spaces
- Wrong App Password
- 2-Step Verification not enabled
- Using regular password instead of App Password

**Fix:**
1. Verify 2-Step Verification is enabled
2. Generate a NEW App Password
3. Copy it WITHOUT spaces
4. Update `.env` file

---

#### Error: "Connection timeout"
```
SMTP Error: dial tcp: i/o timeout
```

**Causes:**
- Firewall blocking port 587
- Network issues
- Wrong SMTP host/port

**Fix:**
1. Check firewall settings
2. Verify `smtp.gmail.com:587` is correct
3. Try from different network

---

#### Error: "Invalid request body"
```
Failed to decode JSON body: invalid character...
```

**Causes:**
- Malformed JSON in request
- Missing Content-Type header

**Fix:**
1. Ensure `Content-Type: application/json` header
2. Validate JSON syntax
3. Check for trailing commas

---

## Environment Variables Checklist

### .env File Format

```env
GMAIL_EMAIL=kudhar892@gmail.com
GMAIL_APP_PASSWORD=abcdabcdabcdabcd
PORT=8910
```

**Important:**
- ✅ No quotes around values
- ✅ No spaces in app password
- ✅ Exactly 16 characters for app password
- ✅ File named `.env` (not `.env.txt`)

---

## Verification Steps

### Step 1: Check Environment Variables
```bash
cd e:\mission\portfolio\backend
go run main.go
```

Look for:
```
Using Gmail account: kud***@gmail.com
App password length: 16 characters
```

### Step 2: Test Health Endpoint
```bash
curl http://localhost:8910/health
```

Expected:
```json
{"success":true,"message":"API is healthy"}
```

### Step 3: Test Contact Endpoint
```bash
curl -X POST http://localhost:8910/api/contact \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@test.com","message":"Test message here"}'
```

Expected:
```json
{"success":true,"message":"Email sent successfully"}
```

### Step 4: Check Your Email
- Check `kudhar892@gmail.com` inbox
- Look for email with subject "Portfolio Contact from John"
- Verify HTML formatting

---

## What Changed in the Code

### main.go Changes

**Line 50:** Added space removal from app password
```go
gmailPassword = strings.ReplaceAll(gmailPassword, " ", "")
```

**Line 54:** Added app password length logging
```go
log.Printf("App password length: %d characters", len(gmailPassword))
```

**Lines 76, 93, 110, 191, 198:** Added detailed logging throughout

**Lines 229-233 in formatEmailBody():** Added default subject handling
```go
subject := req.Subject
if subject == "" {
    subject = fmt.Sprintf("Portfolio Contact from %s", req.Name)
}
```

---

## Quick Troubleshooting

| Symptom | Likely Cause | Solution |
|---------|-------------|----------|
| 500 error | App password has spaces | Remove spaces from `.env` |
| 535 auth failed | Wrong app password | Generate new app password |
| Connection timeout | Firewall/network | Check port 587 access |
| Invalid JSON | Malformed request | Validate JSON syntax |
| App password length ≠ 16 | Spaces or wrong password | Check `.env` file |

---

## Next Steps

1. ✅ Restart the Go server
2. ✅ Verify app password length is 16
3. ✅ Test with curl
4. ✅ Check email inbox
5. ✅ Integrate with Flutter app

If you still get 500 errors, check the console logs for the exact SMTP error message!
