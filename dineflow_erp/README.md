# DineFlow - Flutter Mobile App

A Flutter-based mobile application for seamless dining experiences with integrated Auth0 authentication.

## Features

- 🔐 **Secure Authentication**: Login and signup using Auth0 with social providers
- 👤 **User Profiles**: Personalized user experience with profile management
- 🎨 **Modern UI**: Clean, intuitive interface with Material Design
- 📱 **Cross-Platform**: Works on both Android and iOS devices
- 🔒 **Secure Storage**: Encrypted token storage for session management

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode for device testing
- Auth0 account for authentication

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ikamalagrahari/DineFlow-App.git
   cd DineFlow-App/dineflow_erp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Auth0:**
   - Follow the [Auth0 Setup Guide](../AUTH0_SETUP.md) to configure authentication
   - Update `lib/config/auth_config.dart` with your Auth0 credentials

4. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── config/
│   └── auth_config.dart          # Auth0 configuration
├── providers/
│   └── auth_provider.dart        # Authentication state management
├── screens/
│   ├── welcome_screen.dart       # Login/Signup screen
│   └── home_screen.dart          # Main app screen
├── services/
│   └── auth_service.dart         # Auth0 integration service
└── main.dart                     # App entry point
```

## Authentication Flow

1. **Welcome Screen**: Users can choose to login or signup
2. **Auth0 Universal Login**: Secure authentication via Auth0
3. **Token Storage**: Secure storage of authentication tokens
4. **Home Screen**: Authenticated users see the main app interface
5. **Session Management**: Automatic token refresh and logout handling

## Development

### Running Tests

```bash
flutter test
```

### Building for Release

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Configuration

### Auth0 Setup

1. Create an Auth0 application (Native type)
2. Configure callback URLs with your app's scheme
3. Update `lib/config/auth_config.dart` with your credentials
4. See [AUTH0_SETUP.md](../AUTH0_SETUP.md) for detailed instructions

### Deep Linking

The app uses the `dineflow://` URL scheme for Auth0 callbacks. This is configured in:
- Android: `android/app/src/main/AndroidManifest.xml`
- iOS: `ios/Runner/Info.plist`

## Dependencies

- `flutter`: Flutter SDK
- `auth0_flutter`: Auth0 authentication
- `provider`: State management
- `flutter_secure_storage`: Secure token storage
- `http`: HTTP requests
- `cupertino_icons`: iOS-style icons

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## Troubleshooting

### Common Issues

1. **Configuration Error Screen**: Update Auth0 credentials in `auth_config.dart`
2. **Authentication Failures**: Check Auth0 callback URLs and app bundle ID
3. **Build Errors**: Run `flutter clean && flutter pub get`

### Debug Tips

- Enable Auth0 debug logs in the dashboard
- Use `flutter logs` for detailed error information
- Test on physical devices for deep linking

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## Support

- [Flutter Documentation](https://docs.flutter.dev/)
- [Auth0 Documentation](https://auth0.com/docs/quickstart/native/flutter)
- [Project Issues](https://github.com/ikamalagrahari/DineFlow-App/issues)
