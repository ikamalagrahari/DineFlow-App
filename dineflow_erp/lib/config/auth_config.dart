class AuthConfig {
  // TODO: Replace with your actual Auth0 configuration
  // You can get these values from your Auth0 Dashboard
  
  // For development, you can use environment variables or create a separate config file
  // that is not tracked by git (add to .gitignore)
  
  static const String domain = 'YOUR_AUTH0_DOMAIN'; // e.g., 'dev-12345.auth0.com'
  static const String clientId = 'YOUR_AUTH0_CLIENT_ID'; // e.g., 'abc123def456...'
  
  // Custom scheme for deep linking - should match your app bundle ID
  static const String scheme = 'dineflow';
  
  // Validate configuration
  static bool get isConfigured => 
      domain != 'YOUR_AUTH0_DOMAIN' && 
      clientId != 'YOUR_AUTH0_CLIENT_ID' &&
      domain.isNotEmpty &&
      clientId.isNotEmpty;
      
  static String get configurationError {
    if (!isConfigured) {
      return 'Auth0 configuration is incomplete. Please update lib/config/auth_config.dart with your Auth0 domain and client ID.';
    }
    return '';
  }
}