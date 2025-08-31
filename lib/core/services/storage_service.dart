import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class StorageService {
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _lastLocationKey = 'last_location';
  static const String _searchHistoryKey = 'search_history';
  static const String _favoritesKey = 'favorites';

  // Auth token management
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  Future<void> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }

  // User data management
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return jsonDecode(userDataString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }

  // Location management
  Future<void> saveLastLocation(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    final locationData = {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    await prefs.setString(_lastLocationKey, jsonEncode(locationData));
  }

  Future<Map<String, dynamic>?> getLastLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationString = prefs.getString(_lastLocationKey);
    if (locationString != null) {
      return jsonDecode(locationString) as Map<String, dynamic>;
    }
    return null;
  }

  // Search history management
  Future<void> addToSearchHistory(Map<String, dynamic> searchQuery) async {
    final box = await Hive.openBox('search_history');
    final history = List<Map<String, dynamic>>.from(
      box.get('history', defaultValue: <Map<String, dynamic>>[]),
    );
    
    // Remove duplicate if exists
    history.removeWhere((item) => 
      item['query'] == searchQuery['query'] && 
      item['type'] == searchQuery['type']
    );
    
    // Add to beginning
    history.insert(0, {
      ...searchQuery,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    
    // Keep only last 10 searches
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }
    
    await box.put('history', history);
  }

  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    final box = await Hive.openBox('search_history');
    final history = box.get('history', defaultValue: <Map<String, dynamic>>[]);
    return List<Map<String, dynamic>>.from(history);
  }

  Future<void> clearSearchHistory() async {
    final box = await Hive.openBox('search_history');
    await box.clear();
  }

  // Favorites management
  Future<void> addToFavorites(int influencerId) async {
    final box = await Hive.openBox('favorites');
    final favorites = List<int>.from(
      box.get('favorites', defaultValue: <int>[]),
    );
    
    if (!favorites.contains(influencerId)) {
      favorites.add(influencerId);
      await box.put('favorites', favorites);
    }
  }

  Future<void> removeFromFavorites(int influencerId) async {
    final box = await Hive.openBox('favorites');
    final favorites = List<int>.from(
      box.get('favorites', defaultValue: <int>[]),
    );
    
    favorites.remove(influencerId);
    await box.put('favorites', favorites);
  }

  Future<List<int>> getFavorites() async {
    final box = await Hive.openBox('favorites');
    final favorites = box.get('favorites', defaultValue: <int>[]);
    return List<int>.from(favorites);
  }

  Future<bool> isFavorite(int influencerId) async {
    final favorites = await getFavorites();
    return favorites.contains(influencerId);
  }

  // Clear all data
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    final searchBox = await Hive.openBox('search_history');
    await searchBox.clear();
    
    final favoritesBox = await Hive.openBox('favorites');
    await favoritesBox.clear();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    return token != null;
  }
} 