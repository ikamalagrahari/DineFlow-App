import 'dart:async';
import 'dart:developer';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String _accessTokenKey = 'access_token';
  static const String _idTokenKey = 'id_token';
  static const String _refreshTokenKey = 'refresh_token';
  
  late Auth0 _auth0;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Authentication state stream
  final StreamController<AuthState> _authStateController = StreamController<AuthState>.broadcast();
  Stream<AuthState> get authState => _authStateController.stream;
  
  AuthState _currentState = AuthState.loading;
  AuthState get currentState => _currentState;
  
  UserProfile? _user;
  UserProfile? get user => _user;
  
  AuthService({
    required String domain,
    required String clientId,
  }) {
    _auth0 = Auth0(domain, clientId);
    _initializeAuth();
  }
  
  Future<void> _initializeAuth() async {
    try {
      // Check if we have stored tokens
      final accessToken = await _secureStorage.read(key: _accessTokenKey);
      if (accessToken != null) {
        // Try to get user info to validate token
        try {
          _user = await _auth0.api.userInfo(accessToken: accessToken);
          _updateAuthState(AuthState.authenticated);
          return;
        } catch (e) {
          // Token is invalid, clear stored tokens
          await _clearTokens();
        }
      }
      _updateAuthState(AuthState.unauthenticated);
    } catch (e) {
      log('Error initializing auth: $e');
      _updateAuthState(AuthState.unauthenticated);
    }
  }
  
  Future<bool> login() async {
    try {
      _updateAuthState(AuthState.loading);
      
      final result = await _auth0.webAuthentication(scheme: 'dineflow').login();
      
      // Store tokens securely
      await _secureStorage.write(key: _accessTokenKey, value: result.accessToken);
      await _secureStorage.write(key: _idTokenKey, value: result.idToken);
      if (result.refreshToken != null) {
        await _secureStorage.write(key: _refreshTokenKey, value: result.refreshToken);
      }
      
      // Get user profile
      _user = result.user;
      _updateAuthState(AuthState.authenticated);
      
      return true;
    } catch (e) {
      log('Login error: $e');
      _updateAuthState(AuthState.error);
      return false;
    }
  }
  
  Future<bool> signup() async {
    try {
      _updateAuthState(AuthState.loading);
      
      // Auth0 handles signup through the universal login page
      // The same login method can be used for both login and signup
      final result = await _auth0.webAuthentication(scheme: 'dineflow').login(
        parameters: {'screen_hint': 'signup'},
      );
      
      // Store tokens securely
      await _secureStorage.write(key: _accessTokenKey, value: result.accessToken);
      await _secureStorage.write(key: _idTokenKey, value: result.idToken);
      if (result.refreshToken != null) {
        await _secureStorage.write(key: _refreshTokenKey, value: result.refreshToken);
      }
      
      // Get user profile
      _user = result.user;
      _updateAuthState(AuthState.authenticated);
      
      return true;
    } catch (e) {
      log('Signup error: $e');
      _updateAuthState(AuthState.error);
      return false;
    }
  }
  
  Future<void> logout() async {
    try {
      _updateAuthState(AuthState.loading);
      
      // Logout from Auth0
      await _auth0.webAuthentication(scheme: 'dineflow').logout();
      
      // Clear stored tokens
      await _clearTokens();
      _user = null;
      
      _updateAuthState(AuthState.unauthenticated);
    } catch (e) {
      log('Logout error: $e');
      // Even if logout fails, clear local data
      await _clearTokens();
      _user = null;
      _updateAuthState(AuthState.unauthenticated);
    }
  }
  
  Future<String?> getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      return token;
    } catch (e) {
      log('Error getting access token: $e');
      return null;
    }
  }
  
  Future<void> _clearTokens() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _idTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
    } catch (e) {
      log('Error clearing tokens: $e');
    }
  }
  
  void _updateAuthState(AuthState newState) {
    _currentState = newState;
    _authStateController.add(newState);
  }
  
  void dispose() {
    _authStateController.close();
  }
}

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
  error,
}