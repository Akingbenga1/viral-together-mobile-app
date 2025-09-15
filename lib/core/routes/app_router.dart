import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/login_dark_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/influencer/presentation/pages/influencer_search_page.dart';
import '../../features/influencer/presentation/pages/influencer_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/location/presentation/pages/location_search_page.dart';

// Main pages
import '../../features/about/presentation/pages/about_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../features/partners/presentation/pages/partners_page.dart';
import '../../features/people/presentation/pages/people_page.dart';
import '../../features/pricing/presentation/pages/pricing_page.dart';
import '../../features/privacy/presentation/pages/privacy_page.dart';
import '../../features/help/presentation/pages/help_page.dart';

// Blog pages
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/blog/presentation/pages/blog_detail_page.dart';

// Admin pages
import '../../features/admin/presentation/pages/admin_analytics_page.dart';
import '../../features/admin/presentation/pages/admin_businesses_page.dart';
import '../../features/admin/presentation/pages/admin_influencers_page.dart';
import '../../features/admin/presentation/pages/admin_revenue_page.dart';
import '../../features/admin/presentation/pages/admin_subscriptions_page.dart';

// Dashboard pages
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String loginDark = '/login-dark';
  static const String register = '/register';
  static const String home = '/home';
  static const String influencerSearch = '/influencer-search';
  static const String influencerDetail = '/influencer-detail';
  static const String profile = '/profile';
  static const String locationSearch = '/location-search';

  // Main pages
  static const String about = '/about';
  static const String contact = '/contact';
  static const String partners = '/partners';
  static const String people = '/people';
  static const String pricing = '/pricing';
  static const String privacy = '/privacy';
  static const String help = '/help';

  // Blog pages
  static const String blog = '/blog';
  static const String blogDetail = '/blog-detail';

  // Admin pages
  static const String adminAnalytics = '/admin-analytics';
  static const String adminBusinesses = '/admin-businesses';
  static const String adminInfluencers = '/admin-influencers';
  static const String adminRevenue = '/admin-revenue';
  static const String adminSubscriptions = '/admin-subscriptions';

  // Dashboard pages
  static const String dashboard = '/dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
        
      case loginDark:
        return MaterialPageRoute(builder: (_) => const LoginDarkPage());
      
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      
      case influencerSearch:
        return MaterialPageRoute(builder: (_) => const InfluencerSearchPage());
      
      case influencerDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => InfluencerDetailPage(influencerId: args['influencerId'] as int),
        );
      
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      
      case locationSearch:
        return MaterialPageRoute(builder: (_) => const LocationSearchPage());

      // Main pages
      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
        
      case contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());
        
      case partners:
        return MaterialPageRoute(builder: (_) => const PartnersPage());
        
      case people:
        return MaterialPageRoute(builder: (_) => const PeoplePage());
        
      case pricing:
        return MaterialPageRoute(builder: (_) => const PricingPage());
        
      case privacy:
        return MaterialPageRoute(builder: (_) => const PrivacyPage());
        
      case help:
        return MaterialPageRoute(builder: (_) => const HelpPage());

      // Blog pages
      case blog:
        return MaterialPageRoute(builder: (_) => const BlogPage());
        
      case blogDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlogDetailPage(post: args),
        );

      // Admin pages
      case adminAnalytics:
        return MaterialPageRoute(builder: (_) => const AdminAnalyticsPage());
        
      case adminBusinesses:
        return MaterialPageRoute(builder: (_) => const AdminBusinessesPage());
        
      case adminInfluencers:
        return MaterialPageRoute(builder: (_) => const AdminInfluencersPage());
        
      case adminRevenue:
        return MaterialPageRoute(builder: (_) => const AdminRevenuePage());
        
      case adminSubscriptions:
        return MaterialPageRoute(builder: (_) => const AdminSubscriptionsPage());

      // Dashboard pages
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}

class AuthGuard extends StatelessWidget {
  final Widget child;
  
  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return child;
        } else {
          return const LoginPage();
        }
      },
    );
  }
} 