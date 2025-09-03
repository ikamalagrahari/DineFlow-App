import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'config/auth_config.dart';
import 'providers/auth_provider.dart';
import 'services/auth_service.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';

// This is an example of a Flutter app that fetches data from an API.

// --- 1. Data Model ---
// A class to represent a single Post from the API.
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // A factory constructor to create a Post from a JSON object.
  // This is used for parsing the API response.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

// --- 2. API Service ---
// A function that handles the network request and parsing.
Future<List<Post>> fetchPosts() async {
  // The API endpoint we want to fetch data from.
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/posts'));
  // If you are running on physical device for emulation, change the IP address to your Network IP address.

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, then parse the JSON.
    final List<dynamic> parsed = jsonDecode(response.body);
    // Convert the list of JSON objects to a list of Post objects.
    return parsed.map((json) => Post.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load posts');
  }
}

// --- Main App ---
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Show configuration error if Auth0 is not properly configured
    if (!AuthConfig.isConfigured) {
      return MaterialApp(
        title: 'DineFlow Configuration Error',
        home: ConfigurationErrorScreen(),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            authService: AuthService(
              domain: AuthConfig.domain,
              clientId: AuthConfig.clientId,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'DineFlow',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Show loading screen during auth initialization
        if (authProvider.isLoading && !authProvider.isAuthenticated) {
          return const LoadingScreen();
        }
        
        // Show home screen if authenticated
        if (authProvider.isAuthenticated) {
          return const HomeScreen();
        }
        
        // Show welcome screen if not authenticated
        return const WelcomeScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade400,
              Colors.deepOrange.shade600,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Icon(
                Icons.restaurant_menu,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 24),
              Text(
                'DineFlow',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfigurationErrorScreen extends StatelessWidget {
  const ConfigurationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration Error'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            const Text(
              'Auth0 Configuration Required',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              AuthConfig.configurationError,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setup Instructions:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '1. Create an Auth0 application\n'
                      '2. Copy your domain and client ID\n'
                      '3. Update lib/config/auth_config.dart\n'
                      '4. Configure callback URLs\n'
                      '5. Restart the application',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. UI to Display the Data (Legacy - keeping for reference) ---
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  // A Future that will hold the network request result.
  // We store it in the state to prevent it from being called on every rebuild.
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    // Call the fetch function when the widget is first created.
    futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts from API'),
      ),
      body: Center(
        // FutureBuilder is the perfect widget for working with async data.
        child: FutureBuilder<List<Post>>(
          future: futurePosts, // The future we want to monitor.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the data is loading, show a progress indicator.
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred, display the error message.
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If the data has been successfully fetched, display it in a list.
              final posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(post.id.toString())),
                      title: Text(post.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              );
            } else {
              // By default, show a text message.
              return const Text('No posts found.');
            }
          },
        ),
      ),
    );
  }
}
