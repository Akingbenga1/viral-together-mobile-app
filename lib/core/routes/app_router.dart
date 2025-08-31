import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/influencer/presentation/pages/influencer_search_page.dart';
import '../../features/influencer/presentation/pages/influencer_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/location/presentation/pages/location_search_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String influencerSearch = '/influencer-search';
  static const String influencerDetail = '/influencer-detail';
  static const String profile = '/profile';
  static const String locationSearch = '/location-search';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      
      case influencerSearch:
        return MaterialPageRoute(
          builder: (_) => const InfluencerSearchPage(),
        );
      
      case influencerDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => InfluencerDetailPage(
            influencerId: args['influencerId'] as int,
          ),
        );
      
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );
      
      case locationSearch:
        return MaterialPageRoute(
          builder: (_) => const LocationSearchPage(),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
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