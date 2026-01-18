# Portfolio Project - Complete Overview

A full-stack Flutter portfolio application with a Go backend API for contact form email functionality.

## Tech Stack

### Frontend
- **Framework:** Flutter (Web, Android, iOS)
- **State Management:** Riverpod
- **Routing:** GoRouter
- **UI/UX:** Google Fonts, Font Awesome Icons, Flutter Animate
- **HTTP Client:** http package

### Backend
- **Language:** Go (Golang)
- **Email Service:** Gmail SMTP with App Password
- **Environment Management:** godotenv
- **API Type:** RESTful JSON API

## Project Architecture

### Flutter App - Clean Architecture

```
lib/
├── core/
│   ├── router/
│   │   └── app_router.dart          # GoRouter configuration
│   └── theme/
│       └── theme.dart                # App theme (dark mode)
│
├── features/
│   ├── about/
│   │   └── presentation/
│   │       └── about_screen.dart     # About section
│   │
│   ├── contact/
│   │   ├── domain/
│   │   │   └── contact_model.dart    # Contact data model
│   │   ├── data/
│   │   │   └── contact_api_service.dart  # API service
│   │   └── presentation/
│   │       └── contact_screen.dart   # Contact form UI
│   │
│   ├── experience/
│   │   └── presentation/
│   │       └── experience_screen.dart  # Work experience
│   │
│   ├── home/
│   │   └── presentation/
│   │       └── home_screen.dart      # Hero section
│   │
│   ├── projects/
│   │   └── presentation/
│   │       └── projects_screen.dart  # Portfolio projects
│   │
│   └── skills/
│       └── presentation/
│           └── skills_screen.dart    # Technical skills
│
├── shared/ 
│   └── widgets/
│       ├── bottom_navigation_bar.dart  # Mobile navigation
│       ├── social_media_icon.dart      # Social media icons
│       └── top_navigation_bar.dart     # Desktop navigation
│
└── main.dart                         # App entry point
```

### Backend - Go API

```
backend/
├── main.go                           # Main server & API logic
├── go.mod                            # Go dependencies
├── go.sum                            # Dependency checksums
├── .env                              # Environment variables (gitignored)
├── .env.example                      # Environment template
├── .gitignore                        # Git ignore rules
├── README.md                         # Backend documentation
├── DEBUGGING_GUIDE.md                # Troubleshooting guide
├── TEST_GUIDE.md                     # Testing examples
└── Portfolio_Contact_API.postman_collection.json  # Postman tests
```

## Features

### 1. Home Section
- Hero banner with introduction
- Animated text effects
- Call-to-action buttons
- Responsive layout

### 2. About Section
- Professional summary
- Background information
- Personal interests
- Animated entrance effects

### 3. Skills Section
- Technical skills display
- Categorized skill chips
- Visual skill indicators
- Responsive grid layout

### 4. Experience Section
- Work history timeline
- Company details
- Role descriptions
- Duration and achievements

### 5. Projects Section
- Portfolio project showcase
- Project cards with:
  - Title and description
  - Tech stack tags
  - GitHub links
  - Project status
  - Category labels
- Private repository support

### 6. Contact Section
**Frontend:**
- Contact form with fields:
  - Name (required, min 3 chars)
  - Email (required, valid format)
  - Subject (optional)
  - Message (required, min 10 chars)
- Form validation
- Loading states
- Success/Error dialogs
- Social media links (LinkedIn, GitHub, Email)

**Backend API:**
- POST `/api/contact` endpoint
- Email sending via Gmail SMTP
- Request validation
- Error handling
- CORS support
- HTML email templates

### 7. Navigation
- **Desktop:** Top navigation bar with centered menu items
- **Mobile:** Bottom navigation bar
- Smooth scrolling between sections
- Active section highlighting

## API Documentation

### Endpoint: POST /api/contact

**Request:**
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "subject": "Optional subject",
  "message": "Message content"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Email sent successfully"
}
```

**Error Response (400/500):**
```json
{
  "success": false,
  "message": "Error description"
}
```

### Endpoint: GET /health

**Response (200):**
```json
{
  "success": true,
  "message": "API is healthy"
}
```

## Environment Configuration

### Backend (.env)
```env
GMAIL_EMAIL=your-email@gmail.com
GMAIL_APP_PASSWORD=your-16-char-app-password
PORT=8910
```

### Frontend API Configuration
**File:** `lib/features/contact/data/contact_api_service.dart`
```dart
static const String _baseUrl = 'http://localhost:8910';  // Dev
// static const String _baseUrl = 'https://your-domain.com';  // Prod
```

## Dependencies

### Flutter (pubspec.yaml)
```yaml
dependencies:
  flutter_riverpod: ^2.6.1      # State management
  go_router: ^14.6.0            # Routing
  google_fonts: ^6.2.1          # Typography
  url_launcher: ^6.3.1          # External links
  font_awesome_flutter: ^10.7.0 # Icons
  flutter_animate: ^4.5.0       # Animations
  http: ^1.1.0                  # API calls
```

### Go (go.mod)
```go
require github.com/joho/godotenv v1.5.1
```

## Design System

### Theme
- **Mode:** Dark theme
- **Primary Color:** Teal/Cyan accent
- **Background:** Dark gray (#0A0E27)
- **Card Color:** Slightly lighter dark (#1A1E3F)
- **Text:** White/Gray hierarchy

### Typography
- **Font Family:** Google Fonts (Poppins, Inter)
- **Hierarchy:** Display, Headline, Title, Body, Label

### Spacing
- **Grid:** 8px base unit
- **Padding:** 8, 16, 24, 32, 40, 60
- **Border Radius:** 8, 12, 16, 20, 24

### Animations
- Fade in effects
- Slide transitions
- Hover states
- Loading indicators

## Responsive Design

### Breakpoints
- **Mobile:** < 600px
- **Tablet:** 600px - 900px
- **Desktop:** > 900px

### Adaptive Layouts
- **Desktop:** Side-by-side layouts, top navigation
- **Mobile:** Stacked layouts, bottom navigation
- **Tablet:** Hybrid approach

## Error Handling

### Frontend
- Form validation errors
- Network errors (no internet)
- Timeout errors (10s limit)
- Server errors (400, 500)
- JSON parsing errors

### Backend
- Missing environment variables
- Invalid request body
- Validation errors
- SMTP authentication failures
- Email sending failures

## Testing

### Backend Testing
**Tools:**
- curl commands
- Postman collection
- PowerShell scripts

**Test Cases:**
- Health check
- Valid contact submission
- Validation errors (missing fields, invalid email, short message)
- Method not allowed (GET on /api/contact)

### Frontend Testing
**Manual Tests:**
- Form validation
- API integration
- Success/Error dialogs
- Loading states
- Responsive design

## Security Features

### Backend
- Environment variables for credentials
- Gmail App Password (not account password)
- Email masking in logs
- CORS configuration
- Input validation
- No credential logging

### Frontend
- Client-side validation
- Secure API communication
- No sensitive data storage

## File Structure Summary

```
portfolio/
├── lib/                          # Flutter source code
│   ├── core/                     # Core functionality
│   ├── features/                 # Feature modules
│   ├── shared/                   # Shared widgets
│   └── main.dart                 # Entry point
│
├── backend/                      # Go backend API
│   ├── main.go                   # Server code
│   ├── *.md                      # Documentation
│   └── *.json                    # Postman collection
│
├── assets/                       # Images, icons
├── web/                          # Web-specific files
├── android/                      # Android platform
├── ios/                          # iOS platform
├── pubspec.yaml                  # Flutter dependencies
├── INTEGRATION_GUIDE.md          # Integration docs
└── README.md                     # Project readme
```

## Development Setup

### Prerequisites
- Flutter SDK (latest stable)
- Go 1.21+
- Gmail account with App Password
- Git

### Flutter Setup
```bash
# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Build for web
flutter build web --release
```

### Backend Setup
```bash
# Navigate to backend
cd backend

# Install dependencies
go mod download

# Create .env file
cp .env.example .env
# Edit .env with your credentials

# Run server
go run main.go
```

## Deployment

### Flutter Web
1. Build: `flutter build web --release`
2. Deploy `build/web/` to hosting (Firebase, Netlify, Vercel)
3. Update API base URL to production

### Go Backend
1. Deploy to server (DigitalOcean, AWS, Heroku)
2. Set environment variables
3. Set up HTTPS with SSL
4. Configure CORS for production domain
5. Use process manager (systemd, PM2)

## Key Achievements

✅ **Full-stack application** - Flutter + Go  
✅ **Clean architecture** - Separation of concerns  
✅ **Responsive design** - Mobile, tablet, desktop  
✅ **Email integration** - Gmail SMTP  
✅ **Error handling** - Comprehensive coverage  
✅ **API documentation** - README, Postman, test guides  
✅ **Dark theme** - Modern, professional design  
✅ **Animations** - Smooth, engaging UX  
✅ **Form validation** - Client & server-side  
✅ **Production ready** - Deployment guides included  

## Performance Optimizations

- Lazy loading of sections
- Optimized animations
- Efficient state management
- API timeout handling (10s)
- Minimal dependencies
- Tree-shaken builds

## Accessibility

- Semantic HTML structure
- Keyboard navigation support
- Screen reader friendly
- High contrast dark theme
- Clear error messages
- Loading indicators

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge
- Mobile browsers

## Future Enhancements

Potential improvements:
- Blog section
- Project filtering/search
- Dark/Light theme toggle
- Multi-language support
- Analytics integration
- Contact form captcha
- Rate limiting on API
- Database for contact submissions
- Admin dashboard

## License

This project structure and architecture can be used as a template for portfolio websites.

---

**Total Files:** 30+ Dart files, 1 Go file, 10+ documentation files  
**Lines of Code:** ~3000+ (Flutter) + ~300 (Go)  
**Architecture:** Clean Architecture (Flutter), RESTful API (Go)  
**Platforms:** Web, Android, iOS (Flutter), Server (Go)
