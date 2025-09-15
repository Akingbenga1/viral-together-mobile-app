import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/bloc/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // For now, show a general dashboard. In a real app, this would vary by user type
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.1),
                        AppTheme.secondaryColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s what\'s happening with your campaigns and influencer connections.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Quick Stats
                Text(
                  'Quick Stats',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      context: context,
                      title: 'Active Campaigns',
                      value: '12',
                      icon: Icons.campaign,
                      color: Colors.blue,
                    ),
                    _buildStatCard(
                      context: context,
                      title: 'Total Reach',
                      value: '2.3M',
                      icon: Icons.people,
                      color: Colors.green,
                    ),
                    _buildStatCard(
                      context: context,
                      title: 'Engagement Rate',
                      value: '4.7%',
                      icon: Icons.trending_up,
                      color: Colors.purple,
                    ),
                    _buildStatCard(
                      context: context,
                      title: 'Budget Used',
                      value: '68%',
                      icon: Icons.monetization_on,
                      color: Colors.orange,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Quick Actions
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _buildActionCard(
                      context: context,
                      title: 'Find Influencers',
                      subtitle: 'Discover new creators',
                      icon: Icons.search,
                      onTap: () => Navigator.of(context).pushNamed('/influencer-search'),
                    ),
                    _buildActionCard(
                      context: context,
                      title: 'Create Campaign',
                      subtitle: 'Start a new campaign',
                      icon: Icons.add_circle,
                      onTap: () {},
                    ),
                    _buildActionCard(
                      context: context,
                      title: 'View Analytics',
                      subtitle: 'Check performance',
                      icon: Icons.analytics,
                      onTap: () => Navigator.of(context).pushNamed('/dashboard-analytics'),
                    ),
                    _buildActionCard(
                      context: context,
                      title: 'Manage Budget',
                      subtitle: 'Track spending',
                      icon: Icons.account_balance_wallet,
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Recent Activity
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Activity',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildActivityItem(
                        context: context,
                        icon: Icons.person_add,
                        title: 'New influencer match',
                        subtitle: 'Sarah Johnson accepted your collaboration request',
                        time: '2 hours ago',
                        color: Colors.green,
                      ),

                      _buildActivityItem(
                        context: context,
                        icon: Icons.campaign,
                        title: 'Campaign milestone reached',
                        subtitle: 'Summer Collection campaign hit 1M impressions',
                        time: '1 day ago',
                        color: Colors.blue,
                      ),

                      _buildActivityItem(
                        context: context,
                        icon: Icons.star,
                        title: 'Content delivered',
                        subtitle: 'Mike Chen submitted final content for review',
                        time: '2 days ago',
                        color: Colors.purple,
                      ),

                      _buildActivityItem(
                        context: context,
                        icon: Icons.payment,
                        title: 'Payment processed',
                        subtitle: 'Payment sent to Emma Wilson for sponsored post',
                        time: '3 days ago',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}