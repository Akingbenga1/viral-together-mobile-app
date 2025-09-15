import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../routes/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final isAuthenticated = authState is AuthAuthenticated;
        final isAdmin = authState is AuthAuthenticated && 
                       (authState.user['role'] == 'admin' || 
                        authState.user['isAdmin'] == true);

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer Header
              _buildDrawerHeader(context, authState),
              
              // Main Navigation
              _buildSectionHeader('Main'),
              _buildDrawerItem(
                context,
                icon: Icons.home,
                title: 'Home',
                route: AppRouter.home,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.dashboard,
                title: 'Dashboard',
                route: AppRouter.dashboard,
                requireAuth: true,
                isAuthenticated: isAuthenticated,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.article,
                title: 'Blog',
                route: AppRouter.blog,
              ),
              
              const Divider(),
              
              // Search & Discovery
              _buildSectionHeader('Search & Discovery'),
              _buildDrawerItem(
                context,
                icon: Icons.person_search,
                title: 'Find Influencers',
                route: AppRouter.influencerSearch,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.location_on,
                title: 'Location Search',
                route: AppRouter.locationSearch,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.people,
                title: 'People',
                route: AppRouter.people,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.business,
                title: 'Partners',
                route: AppRouter.partners,
              ),
              
              const Divider(),
              
              // Account & Profile
              if (isAuthenticated) ...[
                _buildSectionHeader('Account'),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  title: 'Profile',
                  route: AppRouter.profile,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
              ],
              
              // Admin Section (Only visible to admin users)
              if (isAdmin) ...[
                const Divider(),
                _buildSectionHeader('Admin'),
                _buildDrawerItem(
                  context,
                  icon: Icons.analytics,
                  title: 'Analytics',
                  route: AppRouter.adminAnalytics,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.business,
                  title: 'Businesses',
                  route: AppRouter.adminBusinesses,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.star,
                  title: 'Influencers',
                  route: AppRouter.adminInfluencers,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.attach_money,
                  title: 'Revenue',
                  route: AppRouter.adminRevenue,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.subscriptions,
                  title: 'Subscriptions',
                  route: AppRouter.adminSubscriptions,
                  requireAuth: true,
                  isAuthenticated: isAuthenticated,
                ),
                const Divider(),
              ],
              
              // Information & Support
              _buildSectionHeader('Information'),
              _buildDrawerItem(
                context,
                icon: Icons.info,
                title: 'About',
                route: AppRouter.about,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.attach_money,
                title: 'Pricing',
                route: AppRouter.pricing,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.help,
                title: 'Help & Support',
                route: AppRouter.help,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.contact_mail,
                title: 'Contact',
                route: AppRouter.contact,
              ),
              _buildDrawerItem(
                context,
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                route: AppRouter.privacy,
              ),
              
              const Divider(),
              
              // Authentication Actions
              if (isAuthenticated)
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () => _signOut(context),
                  isDestructive: true,
                )
              else ...[
                _buildDrawerItem(
                  context,
                  icon: Icons.login,
                  title: 'Sign In',
                  route: AppRouter.login,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_add,
                  title: 'Register',
                  route: AppRouter.register,
                ),
              ],
              
              // Add some bottom padding
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerHeader(BuildContext context, AuthState authState) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      accountName: Text(
        authState is AuthAuthenticated 
            ? authState.user['name'] ?? authState.user['username'] ?? 'User'
            : 'Viral Together',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      accountEmail: Text(
        authState is AuthAuthenticated 
            ? authState.user['email'] ?? 'user@example.com'
            : 'Discover • Connect • Collaborate',
        style: const TextStyle(fontSize: 14),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: authState is AuthAuthenticated 
            ? (authState.user['profileImage'] != null 
                ? ClipOval(
                    child: Image.network(
                      authState.user['profileImage'],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ))
            : Icon(
                Icons.campaign,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
    bool requireAuth = false,
    bool isAuthenticated = false,
    bool isDestructive = false,
  }) {
    // If authentication is required but user is not authenticated, don't show the item
    if (requireAuth && !isAuthenticated) {
      return const SizedBox.shrink();
    }

    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive 
            ? Colors.red 
            : Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive 
              ? Colors.red 
              : Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context); // Close drawer
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      dense: true,
    );
  }

  void _signOut(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.home,
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}