import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:8000'; // For iOS simulator
  // static const String baseUrl = 'https://your-api-domain.com'; // For production
  
  late Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          // Token expired or invalid
          _handleAuthError();
        }
        handler.next(error);
      },
    ));
  }
  
  void _handleAuthError() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }

  // Auth endpoints
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Create form data for OAuth2PasswordRequestForm
      final formData = {
        'username': username,
        'password': password,
      };
      
      final response = await _dio.post('/auth/token', data: formData, options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ));
      
      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return response.data;
      }
      throw Exception('Login failed');
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> register(String username, String password, String email) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'password': password,
        'email': email,
      });
      
      return response.data;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dio.post('/auth/user');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get user data: ${e.toString()}');
    }
  }

  // Influencer endpoints
  Future<List<Map<String, dynamic>>> searchInfluencers({
    List<int>? countryIds,
    String? industry,
    String? platform,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      
      if (countryIds != null && countryIds.isNotEmpty) {
        queryParams['country_ids'] = countryIds;
      }
      if (latitude != null) queryParams['latitude'] = latitude;
      if (longitude != null) queryParams['longitude'] = longitude;
      if (radius != null) queryParams['radius'] = radius;
      
      final response = await _dio.post('/influencer/search/by_criteria', data: queryParams);
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      // Return mock data if API fails
      return _getMockInfluencers();
    }
  }

  Future<Map<String, dynamic>> getInfluencerById(int id) async {
    try {
      final response = await _dio.get('/influencer/get_influencer/$id');
      return response.data;
    } catch (e) {
      // Return mock data if API fails
      return _getMockInfluencerDetail(id);
    }
  }

  Future<Map<String, dynamic>> createInfluencer(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/influencer/create_public', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to create influencer: ${e.toString()}');
    }
  }

  // Countries endpoints
  Future<List<Map<String, dynamic>>> getCountries({String? search}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null) queryParams['search'] = search;
      
      final response = await _dio.get('/api/countries/', queryParameters: queryParams);
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      // Return mock data if API fails
      return _getMockCountries();
    }
  }

  Future<List<String>> getRegions() async {
    try {
      final response = await _dio.get('/api/countries/regions');
      return List<String>.from(response.data);
    } catch (e) {
      // Return mock data if API fails
      return ['North America', 'Europe', 'Asia', 'Africa', 'South America', 'Oceania'];
    }
  }

  // Mock data methods
  List<Map<String, dynamic>> _getMockInfluencers() {
    return [
      {
        'id': 1,
        'user': {
          'username': 'tech_influencer',
          'first_name': 'John',
          'last_name': 'Doe',
          'email': 'john@example.com',
        },
        'base_country': {
          'id': 1,
          'name': 'United States',
          'code': 'US',
        },
        'collaboration_countries': [
          {'id': 1, 'name': 'United States', 'code': 'US'},
          {'id': 2, 'name': 'Canada', 'code': 'CA'},
        ],
        'availability': true,
        'bio': 'Tech enthusiast and content creator',
        'social_media_links': {
          'instagram': 'https://instagram.com/tech_influencer',
          'tiktok': 'https://tiktok.com/@tech_influencer',
        },
        'follower_count': 50000,
        'engagement_rate': 3.2,
      },
      {
        'id': 2,
        'user': {
          'username': 'fashion_blogger',
          'first_name': 'Sarah',
          'last_name': 'Smith',
          'email': 'sarah@example.com',
        },
        'base_country': {
          'id': 2,
          'name': 'Canada',
          'code': 'CA',
        },
        'collaboration_countries': [
          {'id': 2, 'name': 'Canada', 'code': 'CA'},
          {'id': 1, 'name': 'United States', 'code': 'US'},
        ],
        'availability': true,
        'bio': 'Fashion and lifestyle blogger',
        'social_media_links': {
          'instagram': 'https://instagram.com/fashion_blogger',
          'youtube': 'https://youtube.com/fashion_blogger',
        },
        'follower_count': 75000,
        'engagement_rate': 4.1,
      },
      {
        'id': 3,
        'user': {
          'username': 'food_lover',
          'first_name': 'Mike',
          'last_name': 'Johnson',
          'email': 'mike@example.com',
        },
        'base_country': {
          'id': 3,
          'name': 'United Kingdom',
          'code': 'GB',
        },
        'collaboration_countries': [
          {'id': 3, 'name': 'United Kingdom', 'code': 'GB'},
          {'id': 4, 'name': 'France', 'code': 'FR'},
        ],
        'availability': true,
        'bio': 'Food blogger and recipe creator',
        'social_media_links': {
          'instagram': 'https://instagram.com/food_lover',
          'tiktok': 'https://tiktok.com/@food_lover',
        },
        'follower_count': 120000,
        'engagement_rate': 5.8,
      },
    ];
  }

  Map<String, dynamic> _getMockInfluencerDetail(int id) {
    final mockData = _getMockInfluencers();
    final influencer = mockData.firstWhere(
      (item) => item['id'] == id,
      orElse: () => mockData.first,
    );
    
    return {
      ...influencer,
      'detailed_bio': 'This is a detailed bio for the influencer with more information about their content and collaboration preferences.',
      'contact_info': {
        'email': influencer['user']['email'],
        'phone': '+1-555-0123',
      },
      'rates': {
        'instagram_post': 500,
        'instagram_story': 200,
        'tiktok_video': 300,
        'youtube_video': 1000,
      },
      'past_collaborations': [
        'Brand A - Fashion Campaign',
        'Brand B - Tech Review',
        'Brand C - Food Promotion',
      ],
    };
  }

  List<Map<String, dynamic>> _getMockCountries() {
    return [
      {'id': 1, 'name': 'United States', 'code': 'US', 'code3': 'USA', 'region': 'North America'},
      {'id': 2, 'name': 'Canada', 'code': 'CA', 'code3': 'CAN', 'region': 'North America'},
      {'id': 3, 'name': 'United Kingdom', 'code': 'GB', 'code3': 'GBR', 'region': 'Europe'},
      {'id': 4, 'name': 'France', 'code': 'FR', 'code3': 'FRA', 'region': 'Europe'},
      {'id': 5, 'name': 'Germany', 'code': 'DE', 'code3': 'DEU', 'region': 'Europe'},
      {'id': 6, 'name': 'Japan', 'code': 'JP', 'code3': 'JPN', 'region': 'Asia'},
      {'id': 7, 'name': 'South Korea', 'code': 'KR', 'code3': 'KOR', 'region': 'Asia'},
      {'id': 8, 'name': 'Australia', 'code': 'AU', 'code3': 'AUS', 'region': 'Oceania'},
      {'id': 9, 'name': 'Brazil', 'code': 'BR', 'code3': 'BRA', 'region': 'South America'},
      {'id': 10, 'name': 'Mexico', 'code': 'MX', 'code3': 'MEX', 'region': 'North America'},
    ];
  }
} 