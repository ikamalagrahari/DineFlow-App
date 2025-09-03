# DineFlow UI Screenshots & Design Description

## Welcome/Authentication Screen

```
┌─────────────────────────────────────┐
│  🍽️ DineFlow                        │ <- Gradient Background (Orange to Deep Orange)
│                                     │
│     [Restaurant Icon in Circle]     │ <- 120x120 white circle with restaurant icon
│                                     │
│           DineFlow                  │ <- Large white bold text (42px)
│    Your seamless dining             │ <- Subtitle text (18px, white70)
│    experience starts here           │
│                                     │
│  ┌─────────────────────────────────┐ │
│  │          Login                  │ │ <- White button with orange text
│  └─────────────────────────────────┘ │
│                                     │
│  ┌─────────────────────────────────┐ │
│  │         Sign Up                 │ │ <- Outlined white button
│  └─────────────────────────────────┘ │
│                                     │
│   [Error message if auth fails]     │ <- Red error container (when needed)
│                                     │
│  By continuing, you agree to our    │ <- Small text (12px, white70)
│  Terms of Service and Privacy Policy│
└─────────────────────────────────────┘
```

### Loading State:
```
┌─────────────────────────────────────┐
│  🍽️ DineFlow                        │
│                                     │
│     [Restaurant Icon in Circle]     │
│                                     │
│           DineFlow                  │
│                                     │
│     [White Circular Progress]       │ <- Loading spinner
│        Please wait...               │
└─────────────────────────────────────┘
```

## Home Screen (After Authentication)

```
┌─────────────────────────────────────┐
│  DineFlow               [Avatar▼]   │ <- Orange AppBar with user menu
├─────────────────────────────────────┤
│  Welcome back,                      │ <- Orange gradient header
│  John Doe                           │ <- User's name (28px, white, bold)
│  What would you like to eat today?  │ <- Subtitle (16px, white70)
├─────────────────────────────────────┤
│  Quick Actions                      │ <- Section title (22px, bold)
│                                     │
│ ┌─────────────┐ ┌─────────────────┐ │
│ │ 🍽️ Browse    │ │ 🛒 My Orders    │ │ <- Action cards in 2x2 grid
│ │ Menu        │ │                 │ │
│ │ Explore     │ │ Track your      │ │
│ │ dishes      │ │ orders          │ │
│ └─────────────┘ └─────────────────┘ │
│                                     │
│ ┌─────────────┐ ┌─────────────────┐ │
│ │ ❤️ Favorites │ │ 📍 Restaurants  │ │
│ │             │ │                 │ │
│ │ Your fav    │ │ Find nearby     │ │
│ │ dishes      │ │ restaurants     │ │
│ └─────────────┘ └─────────────────┘ │
│                                     │
│  Account Information                │ <- Section title
│ ┌─────────────────────────────────┐ │
│ │ 👤 Name: John Doe               │ │ <- User info card
│ │ ───────────────────────────     │ │
│ │ 📧 Email: john@example.com      │ │
│ │ ───────────────────────────     │ │
│ │ 📅 Member Since: 2024-01-01    │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

### User Profile Modal (Bottom Sheet):
```
┌─────────────────────────────────────┐
│           ───                       │ <- Handle bar
│                                     │
│      [Large Avatar Circle]          │ <- 50px radius avatar
│                                     │
│          John Doe                   │ <- Name (24px, bold)
│      john@example.com               │ <- Email (16px, gray)
│                                     │
│  ┌─────────────────────────────────┐ │
│  │            Close                │ │ <- Close button
│  └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

## Configuration Error Screen

```
┌─────────────────────────────────────┐
│  Configuration Error            [×] │ <- Red AppBar
├─────────────────────────────────────┤
│                                     │
│          ⚠️                         │ <- Large error icon (80px, red)
│                                     │
│    Auth0 Configuration Required     │ <- Title (24px, bold)
│                                     │
│  Auth0 configuration is incomplete. │ <- Error message
│  Please update lib/config/          │
│  auth_config.dart with your Auth0   │
│  domain and client ID.              │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Setup Instructions:             │ │ <- Instructions card
│ │                                 │ │
│ │ 1. Create an Auth0 application  │ │
│ │ 2. Copy your domain and client  │ │
│ │ 3. Update lib/config/auth_con.. │ │
│ │ 4. Configure callback URLs      │ │
│ │ 5. Restart the application      │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

## Loading Screen (App Startup)

```
┌─────────────────────────────────────┐
│                                     │
│                                     │ <- Orange gradient background
│          🍽️                         │ <- Restaurant icon (80px, white)
│                                     │
│         DineFlow                    │ <- App name (32px, white, bold)
│                                     │
│                                     │
│     [White Circular Progress]       │ <- Loading spinner
│         Loading...                  │ <- Loading text
│                                     │
│                                     │
└─────────────────────────────────────┘
```

## Key UI Design Features

### Color Scheme
- **Primary**: Deep Orange (#FF5722)
- **Secondary**: Orange (#FF9800)
- **Background**: White with gradient overlays
- **Text**: Dark gray for primary, white for overlays
- **Accent**: Red for errors, Green for success

### Typography
- **App Title**: 32-42px, Bold, White
- **Headers**: 22-28px, Bold, Dark/White
- **Body Text**: 16-18px, Regular
- **Captions**: 12-14px, Regular, 70% opacity

### Interactive Elements
- **Buttons**: Rounded corners (28px radius for large, 12px for regular)
- **Cards**: Elevated with 4px elevation and 12px radius
- **Icons**: Material Design icons, consistent sizing
- **Loading**: Material CircularProgressIndicator

### Responsiveness
- Adaptive layouts for different screen sizes
- Proper spacing and margins (16-24px standard)
- Grid layouts adjust to screen width
- Text scales appropriately

This design provides a modern, professional look suitable for a restaurant/dining app while maintaining excellent usability and accessibility.