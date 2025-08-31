import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/location/bloc/location_bloc.dart';
import 'features/influencer/bloc/influencer_bloc.dart';
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('app_storage');
  
  // Request location permissions
  await Permission.location.request();
  
  runApp(const ViralTogetherApp());
}

class ViralTogetherApp extends StatelessWidget {
  const ViralTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            apiService: ApiService(),
            storageService: StorageService(),
          ),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),
        ),
        BlocProvider<InfluencerBloc>(
          create: (context) => InfluencerBloc(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Viral Together',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
} 