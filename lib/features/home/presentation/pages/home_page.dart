import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/enhanced_card.dart';
import '../../../../core/widgets/enhanced_button.dart';
import '../../../../core/widgets/stats_card.dart';
import '../../../../core/widgets/enhanced_search_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../widgets/influencer_card.dart';
import '../widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const AppDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomeTab(),
          _buildSearchTab(),
          _buildFavoritesTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textSecondary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        // Enhanced Hero Header with Gradient
        SliverAppBar(
          expandedHeight: 140,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Viral Together',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: AppTheme.spacing12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  // TODO: Navigate to notifications
                },
              ),
            ),
          ],
        ),
        
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Enhanced Search Section
              Container(
                margin: const EdgeInsets.all(AppTheme.spacing24),
                child: HeroSearchBar(
                  hintText: 'Search influencers, categories, locations...',
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRouter.influencerSearch);
                  },
                  suffixActions: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                      ),
                      child: const Icon(
                        Icons.tune,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Platform Stats Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'Platform Insights',
                      subtitle: 'Real-time influencer marketing statistics',
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    
                    // Stats Grid
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            title: 'Active Influencers',
                            value: '12.4K',
                            icon: Icons.star,
                            iconColor: AppTheme.accentOrange,
                            percentage: 12.5,
                            isIncreasing: true,
                            onTap: () => Navigator.of(context).pushNamed(AppRouter.influencerSearch),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing12),
                        Expanded(
                          child: StatsCard(
                            title: 'Total Reach',
                            value: '2.8M',
                            icon: Icons.people,
                            iconColor: AppTheme.secondaryColor,
                            percentage: 8.3,
                            isIncreasing: true,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppTheme.spacing12),
                    
                    GradientStatsCard(
                      title: 'Average Engagement Rate',
                      value: '4.7%',
                      subtitle: 'Industry leading performance',
                      icon: Icons.trending_up,
                      percentage: 15.2,
                      isIncreasing: true,
                      gradient: AppTheme.secondaryGradient,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppTheme.spacing32),

              // Quick Actions Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'Quick Actions',
                      subtitle: 'Jump into what you need most',
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    
                    // Enhanced Quick Action Cards
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: AppTheme.spacing16,
                      mainAxisSpacing: AppTheme.spacing16,
                      childAspectRatio: 1.3,
                      children: [
                        _buildEnhancedQuickActionCard(
                          icon: Icons.location_on,
                          title: 'Find Nearby',
                          subtitle: 'Local influencers',
                          color: AppTheme.accentTeal,
                          onTap: () => Navigator.of(context).pushNamed(AppRouter.locationSearch),
                        ),
                        _buildEnhancedQuickActionCard(
                          icon: Icons.trending_up,
                          title: 'Trending Now',
                          subtitle: 'Hot influencers',
                          color: AppTheme.accentPink,
                          onTap: () => Navigator.of(context).pushNamed(AppRouter.influencerSearch),
                        ),
                        _buildEnhancedQuickActionCard(
                          icon: Icons.analytics,
                          title: 'Analytics',
                          subtitle: 'View insights',
                          color: AppTheme.accentOrange,
                          onTap: () => Navigator.of(context).pushNamed(AppRouter.dashboard),
                        ),
                        _buildEnhancedQuickActionCard(
                          icon: Icons.people_alt,
                          title: 'Community',
                          subtitle: 'Connect & chat',
                          color: AppTheme.primaryAccent,
                          onTap: () => Navigator.of(context).pushNamed(AppRouter.people),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppTheme.spacing32),

              // Featured Influencers Section
              Column(
                children: [
                  SectionHeader(
                    title: 'Featured Influencers',
                    subtitle: 'Top performers this week',
                    actionText: 'View All',
                    actionIcon: Icons.arrow_forward_ios,
                    onActionPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.influencerSearch);
                    },
                  ),
                  
                  // Featured Influencers List
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 220,
                          margin: EdgeInsets.only(
                            right: index < 2 ? AppTheme.spacing16 : 0,
                          ),
                          child: InfluencerCard(
                            influencer: _getMockInfluencer(index),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouter.influencerDetail,
                                arguments: {'influencerId': index + 1},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchTab() {
    return const Center(
      child: Text('Search Tab - Navigate to search page'),
    );
  }

  Widget _buildFavoritesTab() {
    return const Center(
      child: Text('Favorites Tab'),
    );
  }

  Widget _buildProfileTab() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return _buildAuthenticatedProfile();
        } else {
          return _buildGuestProfile();
        }
      },
    );
  }

  Widget _buildAuthenticatedProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 32),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          _buildProfileMenuItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {},
          ),
          _buildProfileMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          _buildProfileMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGuestProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 32),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primaryColor,
            child: const Icon(
              Icons.person_outline,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Guest User',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to access all features',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.login);
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return EnhancedCard(
      variant: CardVariant.outlined,
      onTap: onTap,
      showShadow: false,
      padding: const EdgeInsets.all(AppTheme.spacing20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Map<String, dynamic> _getMockInfluencer(int index) {
    final mockData = [
      {
        'id': 1,
        'user': {
          'username': 'tech_influencer',
          'first_name': 'John',
          'last_name': 'Doe',
        },
        'bio': 'Tech enthusiast and content creator',
        'follower_count': 50000,
        'engagement_rate': 3.2,
      },
      {
        'id': 2,
        'user': {
          'username': 'fashion_blogger',
          'first_name': 'Sarah',
          'last_name': 'Smith',
        },
        'bio': 'Fashion and lifestyle blogger',
        'follower_count': 75000,
        'engagement_rate': 4.1,
      },
      {
        'id': 3,
        'user': {
          'username': 'food_lover',
          'first_name': 'Mike',
          'last_name': 'Johnson',
        },
        'bio': 'Food blogger and recipe creator',
        'follower_count': 120000,
        'engagement_rate': 5.8,
      },
    ];
    
    return mockData[index];
  }
} 