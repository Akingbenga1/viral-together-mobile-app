# Viral Together Mobile App

A location-based social media influencer discovery app built with Flutter. This app helps businesses and users find social media influencers based on their location, niche, and other criteria.

## 🚀 Features

### Core Features
- **Location-based Search**: Find influencers near you or in specific locations
- **Advanced Filtering**: Filter by industry, platform, follower count, and more
- **Influencer Profiles**: Detailed profiles with metrics, rates, and collaboration history
- **User Authentication**: Secure login and registration system
- **Modern UI**: Beautiful Material Design 3 interface
- **Offline Support**: Works with mock data when API is unavailable

### User Experience
- **Guest Mode**: Browse influencers without creating an account
- **Favorites**: Save and manage favorite influencers
- **Search History**: Track your recent searches
- **Responsive Design**: Optimized for all screen sizes
- **Dark/Light Theme**: Automatic theme switching

### Technical Features
- **State Management**: BLoC pattern for scalable state management
- **API Integration**: RESTful API communication with fallback to mock data
- **Location Services**: GPS and address-based location search
- **Google Maps**: Interactive map view for location-based search
- **Local Storage**: Secure data persistence with Hive and SharedPreferences

## 📱 Screenshots

*[Screenshots will be added here]*

## 🛠️ Technology Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: flutter_bloc
- **HTTP Client**: Dio
- **Maps**: google_maps_flutter
- **Location**: geolocator, geocoding
- **Storage**: Hive, SharedPreferences
- **UI**: Material Design 3

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher)
- **Android Studio** (for Android development)
- **Java Development Kit (JDK)** (8 or higher)
- **Git** (for version control)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd viral-together-mobile-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure API (Optional)

Update the API base URL in `lib/core/services/api_service.dart`:

```dart
static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
// static const String baseUrl = 'http://localhost:8000'; // For iOS simulator
// static const String baseUrl = 'https://your-api-domain.com'; // For production
```

### 4. Run the App

```bash
# Run on connected device/emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release
```

## 📦 Building for Production

### Generate APK

```bash
# Debug APK (for testing)
flutter build apk --debug

# Release APK (for distribution)
flutter build apk --release

# Split APKs (optimized for different architectures)
flutter build apk --split-per-abi
```

### Generate App Bundle (Recommended for Play Store)

```bash
flutter build appbundle
```

## 🏗️ Project Structure

```
lib/
├── main.dart                     # App entry point
├── core/                         # Core services and utilities
│   ├── config/                   # App configuration
│   ├── services/                 # API and storage services
│   ├── theme/                    # App theming
│   └── routes/                   # Navigation routes
├── features/                     # Feature modules
│   ├── auth/                     # Authentication
│   │   ├── bloc/                # Auth state management
│   │   └── presentation/        # Auth UI
│   ├── home/                     # Home screen
│   ├── influencer/               # Influencer features
│   ├── location/                 # Location services
│   └── profile/                  # User profile
└── shared/                       # Shared components
    ├── widgets/                  # Reusable widgets
    └── utils/                    # Utility functions
```

## 🔧 Configuration

### Google Maps API Key

For full map functionality, add your Google Maps API key:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Maps SDK for Android
4. Create credentials (API key)
5. Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml`

### API Endpoints

The app connects to the following API endpoints:

- `POST /api/auth/token` - User login
- `POST /api/auth/register` - User registration
- `GET /api/auth/user` - Get current user
- `POST /api/influencer/search/by_criteria` - Search influencers
- `GET /api/influencer/get_influencer/{id}` - Get influencer details
- `GET /api/countries/` - Get countries list
- `GET /api/countries/regions` - Get regions list

## 🎨 UI/UX Features

### Design System
- **Material Design 3**: Modern design language
- **Color Scheme**: Purple primary with green secondary
- **Typography**: Poppins font family
- **Icons**: Material Icons
- **Animations**: Smooth transitions and micro-interactions

### Responsive Design
- **Mobile First**: Optimized for mobile devices
- **Adaptive Layout**: Works on different screen sizes
- **Orientation Support**: Portrait and landscape modes

## 🔐 Security Features

- **Token-based Authentication**: JWT tokens for API requests
- **Secure Storage**: Encrypted local storage for sensitive data
- **Input Validation**: Client-side form validation
- **Error Handling**: Graceful error handling and user feedback

## 📊 Performance

- **Lazy Loading**: Images and data loaded on demand
- **Caching**: API responses cached locally
- **Optimized Images**: Compressed and optimized assets
- **Memory Management**: Efficient memory usage

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

## 📈 Analytics & Monitoring

The app is prepared for analytics integration:

- **User Events**: Track user interactions
- **Performance Metrics**: Monitor app performance
- **Error Reporting**: Capture and report errors
- **Usage Analytics**: Understand user behavior

## 🔄 State Management

The app uses BLoC pattern for state management:

- **AuthBloc**: Handles authentication state
- **InfluencerBloc**: Manages influencer data
- **LocationBloc**: Handles location services

## 🌐 API Integration

### Available Endpoints
- ✅ Authentication (login/register)
- ✅ User profile management
- ⚠️ Influencer search (mock data)
- ⚠️ Influencer details (mock data)
- ⚠️ Countries/regions (mock data)

### Mock Data
When API endpoints are unavailable, the app uses mock data to ensure functionality:

- **Influencers**: 3 sample influencers with detailed profiles
- **Countries**: 10 sample countries
- **Regions**: 6 sample regions

## 🚀 Deployment

### Android
1. Build the APK: `flutter build apk --release`
2. Test on multiple devices
3. Upload to Google Play Store

### iOS (Future)
1. Build for iOS: `flutter build ios --release`
2. Archive in Xcode
3. Upload to App Store Connect

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:

1. Check the [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md) for build issues
2. Review the troubleshooting section
3. Open an issue on GitHub
4. Contact the development team

## 🔮 Roadmap

### Phase 1 (Current)
- ✅ Basic influencer search
- ✅ User authentication
- ✅ Location-based search
- ✅ Modern UI/UX

### Phase 2 (Next)
- 🔄 Push notifications
- 🔄 Real-time messaging
- 🔄 Payment integration
- 🔄 Advanced analytics

### Phase 3 (Future)
- 🔄 AI-powered recommendations
- 🔄 Video content support
- 🔄 Multi-language support
- 🔄 Advanced collaboration tools

## 📄 Changelog

### Version 1.0.0
- Initial release
- Basic influencer search functionality
- User authentication system
- Location-based search
- Modern Material Design 3 UI

---

**Built with ❤️ using Flutter**