import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DineFlow',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return PopupMenuButton<String>(
                icon: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: authProvider.user?.pictureUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            authProvider.user!.pictureUrl!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 18,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline),
                        const SizedBox(width: 8),
                        Text(authProvider.user?.name ?? 'Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'logout') {
                    _showLogoutDialog(context, authProvider);
                  } else if (value == 'profile') {
                    _showUserProfile(context, authProvider);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Welcome Header
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.deepOrange,
                        Colors.deepOrange.shade300,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.user?.name ?? 'Food Lover!',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What would you like to eat today?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Actions
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildActionCard(
                            icon: Icons.restaurant_menu,
                            title: 'Browse Menu',
                            subtitle: 'Explore delicious dishes',
                            color: Colors.blue,
                            onTap: () {
                              // TODO: Navigate to menu screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Menu feature coming soon!'),
                                ),
                              );
                            },
                          ),
                          _buildActionCard(
                            icon: Icons.shopping_cart,
                            title: 'My Orders',
                            subtitle: 'Track your orders',
                            color: Colors.green,
                            onTap: () {
                              // TODO: Navigate to orders screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Orders feature coming soon!'),
                                ),
                              );
                            },
                          ),
                          _buildActionCard(
                            icon: Icons.favorite,
                            title: 'Favorites',
                            subtitle: 'Your favorite dishes',
                            color: Colors.pink,
                            onTap: () {
                              // TODO: Navigate to favorites screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorites feature coming soon!'),
                                ),
                              );
                            },
                          ),
                          _buildActionCard(
                            icon: Icons.location_on,
                            title: 'Restaurants',
                            subtitle: 'Find nearby restaurants',
                            color: Colors.orange,
                            onTap: () {
                              // TODO: Navigate to restaurants screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Restaurants feature coming soon!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // User Info Section
                      const Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                'Name',
                                authProvider.user?.name ?? 'Not provided',
                                Icons.person,
                              ),
                              const Divider(),
                              _buildInfoRow(
                                'Email',
                                authProvider.user?.email ?? 'Not provided',
                                Icons.email,
                              ),
                              const Divider(),
                              _buildInfoRow(
                                'Member Since',
                                authProvider.user?.updatedAt?.toLocal().toString().split(' ')[0] ?? 'Unknown',
                                Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              authProvider.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
  
  void _showUserProfile(BuildContext context, AuthProvider authProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepOrange.shade100,
              backgroundImage: authProvider.user?.pictureUrl != null
                  ? NetworkImage(authProvider.user!.pictureUrl!)
                  : null,
              child: authProvider.user?.pictureUrl == null
                  ? Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.deepOrange,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              authProvider.user?.name ?? 'User',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              authProvider.user?.email ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}