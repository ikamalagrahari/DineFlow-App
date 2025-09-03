# Auth0 Setup Guide for DineFlow

This guide will help you configure Auth0 authentication for the DineFlow Flutter app.

## Prerequisites

- An Auth0 account (sign up at [auth0.com](https://auth0.com) if you don't have one)
- Flutter development environment set up
- DineFlow project cloned locally

## 1. Create an Auth0 Application

1. Log in to your [Auth0 Dashboard](https://manage.auth0.com)
2. Navigate to **Applications** in the left sidebar
3. Click **Create Application**
4. Choose **Native** as the application type
5. Give your application a name (e.g., "DineFlow Mobile")
6. Click **Create**

## 2. Configure Application Settings

Once your application is created:

### Basic Information
- Note down your **Domain** (looks like `dev-12345.auth0.com`)
- Note down your **Client ID** (a long string of characters)

### Application URIs
Configure the following URLs in your Auth0 application settings:

**Allowed Callback URLs:**
```
dineflow://dev-12345.auth0.com/android/com.example.dineflow_erp/callback,
dineflow://dev-12345.auth0.com/ios/com.example.dineflow_erp/callback
```

**Allowed Logout URLs:**
```
dineflow://dev-12345.auth0.com/android/com.example.dineflow_erp/callback,
dineflow://dev-12345.auth0.com/ios/com.example.dineflow_erp/callback
```

**Allowed Origins (CORS):**
```
dineflow://dev-12345.auth0.com
```

> **Note:** Replace `dev-12345.auth0.com` with your actual Auth0 domain and `com.example.dineflow_erp` with your actual app bundle ID.

## 3. Update App Configuration

1. Open the file `lib/config/auth_config.dart`
2. Replace the placeholder values:

```dart
class AuthConfig {
  static const String domain = 'YOUR_ACTUAL_DOMAIN'; // e.g., 'dev-12345.auth0.com'
  static const String clientId = 'YOUR_ACTUAL_CLIENT_ID'; // Your client ID from Auth0
  
  static const String scheme = 'dineflow';
  
  // ... rest of the file remains the same
}
```

## 4. Configure Bundle ID (Important!)

Make sure your app's bundle ID matches what you configured in Auth0:

### Android
- File: `android/app/build.gradle`
- Look for `applicationId` and note the value

### iOS
- File: `ios/Runner.xcodeproj/project.pbxproj`
- Look for `PRODUCT_BUNDLE_IDENTIFIER`

**The bundle ID in your callback URLs must match exactly!**

## 5. Test the Configuration

1. Save all changes
2. Restart your Flutter app (`flutter run`)
3. You should see the welcome screen instead of the configuration error
4. Try logging in - it should open Auth0's universal login page
5. After successful authentication, you should be redirected back to the app

## 6. Customizing Auth0 Login Page

To customize the appearance of your Auth0 login page:

1. Go to **Branding** in your Auth0 Dashboard
2. Upload your logo
3. Customize colors to match your app's theme
4. Configure social login providers if needed

## 7. Social Login (Optional)

To enable social login (Google, Facebook, etc.):

1. Go to **Authentication > Social** in your Auth0 Dashboard
2. Click on the provider you want to enable
3. Follow the setup instructions for each provider
4. Users will then see these options on the login screen

## 8. Production Configuration

For production deployment:

### Environment Variables
Consider using environment variables or build variants to manage different configurations for development, staging, and production.

### Security Considerations
- Use different Auth0 applications for development and production
- Enable MFA (Multi-Factor Authentication) for enhanced security
- Configure appropriate session timeouts
- Review and configure security policies in Auth0 Dashboard

## Troubleshooting

### Common Issues

1. **"Configuration Error" screen appears**
   - Double-check that your domain and client ID are correctly set in `auth_config.dart`
   - Ensure there are no typos or extra spaces

2. **Authentication fails with redirect error**
   - Verify your callback URLs in Auth0 Dashboard match your app's bundle ID
   - Check that the URL scheme `dineflow://` is properly configured

3. **App crashes after login**
   - Check Flutter console for error messages
   - Ensure all dependencies are properly installed (`flutter pub get`)

4. **Deep linking not working**
   - Verify Android manifest and iOS Info.plist configurations
   - Test on a physical device if using an emulator doesn't work

### Debug Tips

- Enable debug logs in Auth0 Dashboard under **Monitoring > Logs**
- Use Flutter's debug console to see detailed error messages
- Test with a simple login first before adding complex features

## Support

- [Auth0 Flutter SDK Documentation](https://auth0.com/docs/quickstart/native/flutter)
- [Auth0 Community Forum](https://community.auth0.com/)
- [Flutter Documentation](https://flutter.dev/docs)

---

**Important:** Keep your Auth0 credentials secure and never commit them to public repositories. Consider using environment variables or secure configuration management for production apps.