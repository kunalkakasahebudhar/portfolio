# Flutter Contact Screen - Backend Integration Requirements

## Current Implementation Analysis

### File: `contact_screen.dart`

**Current Behavior:**
- Uses `mailto:` links to open the user's email client
- Form validation is already implemented
- Loading states and error handling present
- No direct API integration

---

## Required Changes to Integrate with Go Backend API

### 1. Add HTTP Package Dependency

**File:** `pubspec.yaml`

Add the `http` package for making API calls:

```yaml
dependencies:
  http: ^1.1.0
```

**Command to install:**
```bash
flutter pub get
```

---

### 2. Update Contact Screen Imports

**File:** `contact_screen.dart` (Line 1-6)

Add HTTP imports:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;  // ADD THIS
import 'dart:convert';                     // ADD THIS
```

---

### 3. Replace `_sendEmail()` Method

**Current Implementation (Lines 189-240):**
- Uses `mailto:` to open email client
- Encodes data in URL
- Launches email client

**New Implementation Required:**

```dart
Future<void> _sendEmail() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);

  try {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    // Call Go backend API
    final response = await http.post(
      Uri.parse('http://localhost:8910/api/contact'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'subject': 'Portfolio Contact from $name',
        'message': message,
      }),
    );

    if (mounted) {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          // Clear form fields
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully! I\'ll get back to you soon.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );
        }
      } else {
        // Handle API error response
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to send message');
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

---

### 4. Update Loading Button Text

**Current (Line 335):**
```dart
Text('Opening...'),
```

**Change to:**
```dart
Text('Sending...'),
```

---

## Configuration Requirements

### API Endpoint Configuration

**Current:** Hardcoded `http://localhost:8910/api/contact`

**Recommended:** Create a configuration file for different environments

**File:** `lib/core/config/api_config.dart` (NEW FILE)

```dart
class ApiConfig {
  // Development
  static const String devBaseUrl = 'http://localhost:8910';
  
  // Production (update when deployed)
  static const String prodBaseUrl = 'https://your-domain.com';
  
  // Current environment
  static const bool isDevelopment = true;
  
  static String get baseUrl => isDevelopment ? devBaseUrl : prodBaseUrl;
  static String get contactEndpoint => '$baseUrl/api/contact';
}
```

**Then update the API call:**
```dart
final response = await http.post(
  Uri.parse(ApiConfig.contactEndpoint),
  // ... rest of the code
);
```

---

## Validation Alignment

### Current Flutter Validation
- **Name:** Required, min 3 characters ✅
- **Email:** Required, valid format ✅
- **Message:** Required, min 10 characters ✅

### Go Backend Validation
- **Name:** Required, min 3 characters ✅
- **Email:** Required, valid format ✅
- **Message:** Required, min 10 characters ✅
- **Subject:** Optional (defaults to "Portfolio Contact from [Name]")

**Status:** ✅ Validations are already aligned!

---

## Error Handling

### API Error Responses to Handle

**1. Validation Error (400):**
```json
{
  "success": false,
  "message": "email is required"
}
```

**2. Server Error (500):**
```json
{
  "success": false,
  "message": "Failed to send email"
}
```

**3. Network Error:**
- Connection timeout
- No internet connection
- Server not running

**Implementation:**
```dart
try {
  final response = await http.post(...).timeout(
    const Duration(seconds: 10),
    onTimeout: () {
      throw Exception('Request timeout. Please check your connection.');
    },
  );
  // ... handle response
} on SocketException {
  throw Exception('No internet connection');
} on TimeoutException {
  throw Exception('Request timeout');
} catch (e) {
  throw Exception('Failed to send message: ${e.toString()}');
}
```

---

## CORS Considerations

### Development (localhost)
✅ Already handled by Go backend - CORS enabled for all origins

### Production
⚠️ Update Go backend CORS settings to allow only your domain:

```go
// In main.go corsMiddleware function
w.Header().Set("Access-Control-Allow-Origin", "https://your-domain.com")
```

---

## Testing Checklist

### Before Integration
- [ ] Go backend is running on `http://localhost:8910`
- [ ] Test backend with Postman/curl
- [ ] Verify email sending works

### After Integration
- [ ] Add `http` package to `pubspec.yaml`
- [ ] Run `flutter pub get`
- [ ] Update imports in `contact_screen.dart`
- [ ] Replace `_sendEmail()` method
- [ ] Update button loading text
- [ ] Test form validation
- [ ] Test successful submission
- [ ] Test error handling (stop backend and try)
- [ ] Test network timeout
- [ ] Verify email arrives in inbox

---

## Complete Updated Code

### Required Changes Summary

**Files to Modify:**
1. `pubspec.yaml` - Add `http: ^1.1.0`
2. `lib/features/contact/presentation/contact_screen.dart` - Update imports and `_sendEmail()` method

**Optional Files to Create:**
1. `lib/core/config/api_config.dart` - API configuration

**Lines to Change in `contact_screen.dart`:**
- Lines 1-6: Add imports (`http` and `dart:convert`)
- Lines 189-240: Replace entire `_sendEmail()` method
- Line 335: Change "Opening..." to "Sending..."

---

## Production Deployment Notes

### Flutter Web
1. Update `ApiConfig.prodBaseUrl` with your production API URL
2. Set `isDevelopment = false`
3. Build: `flutter build web --release`

### Go Backend
1. Deploy to a server (DigitalOcean, AWS, Heroku, etc.)
2. Set up HTTPS with SSL certificate
3. Update CORS to allow only your domain
4. Set environment variables on server
5. Use a process manager (systemd, PM2)

### DNS & Domains
- Point your domain to the Go backend server
- Update Flutter app to use the production URL
- Test thoroughly before going live

---

## Benefits of API Integration

✅ **Automatic Email Sending** - No user action required  
✅ **Professional Experience** - Seamless form submission  
✅ **HTML Emails** - Beautiful formatted emails  
✅ **Server-side Validation** - Additional security layer  
✅ **Error Tracking** - Better error handling and logging  
✅ **No Email Client Dependency** - Works on all devices  

---

## Comparison: Before vs After

### Before (mailto:)
- ❌ Opens email client
- ❌ User must manually send
- ❌ Depends on email client setup
- ❌ Plain text emails
- ✅ Simple implementation
- ✅ No backend needed

### After (API Integration)
- ✅ Automatic sending
- ✅ No user action needed
- ✅ Works on all devices
- ✅ Beautiful HTML emails
- ✅ Server-side validation
- ❌ Requires backend server
- ❌ More complex setup

---

## Quick Start Guide

1. **Add HTTP package:**
   ```bash
   cd e:\mission\portfolio
   # Add http: ^1.1.0 to pubspec.yaml
   flutter pub get
   ```

2. **Start Go backend:**
   ```bash
   cd backend
   go run main.go
   ```

3. **Update contact_screen.dart:**
   - Add imports
   - Replace `_sendEmail()` method
   - Update button text

4. **Test:**
   ```bash
   flutter run -d chrome
   ```

5. **Submit test form and check your email!**
