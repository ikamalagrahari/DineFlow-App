import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  
  AuthProvider({required AuthService authService}) : _authService = authService {
    // Listen to auth state changes
    _authService.authState.listen((state) {
      notifyListeners();
    });
  }
  
  // Getters to expose auth service properties
  AuthState get authState => _authService.currentState;
  bool get isAuthenticated => authState == AuthState.authenticated;
  bool get isLoading => authState == AuthState.loading;
  bool get hasError => authState == AuthState.error;
  bool get isUnauthenticated => authState == AuthState.unauthenticated;
  
  // User profile getter
  get user => _authService.user;
  
  // Authentication methods
  Future<bool> login() async {
    final result = await _authService.login();
    notifyListeners();
    return result;
  }
  
  Future<bool> signup() async {
    final result = await _authService.signup();
    notifyListeners();
    return result;
  }
  
  Future<void> logout() async {
    await _authService.logout();
    notifyListeners();
  }
  
  Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }
  
  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }
}