import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PostsPage(),
    );
  }
}

// --- 3. UI to Display the Data ---
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
