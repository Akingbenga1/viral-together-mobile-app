# Viral Together Mobile App - Build Instructions

This document provides step-by-step instructions to build the Viral Together Flutter app and generate an APK file for Android installation.

## Prerequisites

1. **Flutter SDK** (version 3.0.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH

2. **Android Studio** (recommended)
   - Download from: https://developer.android.com/studio
   - Install Android SDK

3. **Java Development Kit (JDK)** (version 8 or higher)

4. **Git** (for version control)

## Setup Instructions

### 1. Install Flutter Dependencies

```bash
# Navigate to the project directory
cd viral-together-mobile-app

# Get Flutter dependencies
flutter pub get
```

### 2. Configure Android Settings

1. **Update Android SDK**:
   - Open Android Studio
   - Go to Tools > SDK Manager
   - Install Android SDK 33 (API level 33) or higher
   - Install Android SDK Build-Tools

2. **Accept Android Licenses**:
   ```bash
   flutter doctor --android-licenses
   ```

3. **Verify Flutter Setup**:
   ```bash
   flutter doctor
   ```
   Make sure all checks pass (✓).

### 3. Configure Google Maps API Key (Optional)

For full map functionality, you'll need a Google Maps API key:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Maps SDK for Android
4. Create credentials (API key)
5. Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml`

## Building the APK

### Method 1: Debug APK (Recommended for testing)

```bash
# Build debug APK
flutter build apk --debug

# The APK will be located at:
# build/app/outputs/flutter-apk/app-debug.apk
```

### Method 2: Release APK (For distribution)

```bash
# Build release APK
flutter build apk --release

# The APK will be located at:
# build/app/outputs/flutter-apk/app-release.apk
```

### Method 3: Split APKs (Optimized for different architectures)

```bash
# Build split APKs
flutter build apk --split-per-abi

# This creates three APKs:
# app-armeabi-v7a-release.apk
# app-arm64-v8a-release.apk
# app-x86_64-release.apk
```

## Installing the APK

### On Android Device:

1. **Enable Unknown Sources**:
   - Go to Settings > Security
   - Enable "Unknown Sources" or "Install unknown apps"

2. **Transfer APK**:
   - Copy the APK file to your Android device
   - Use USB, email, or cloud storage

3. **Install**:
   - Open the APK file on your device
   - Follow the installation prompts

### Using ADB (Android Debug Bridge):

```bash
# Install via ADB (device must be connected via USB)
adb install build/app/outputs/flutter-apk/app-debug.apk
```

## Troubleshooting

### Common Issues:

1. **"Flutter command not found"**:
   - Add Flutter to your PATH
   - Restart terminal/command prompt

2. **"Android SDK not found"**:
   - Install Android Studio
   - Set ANDROID_HOME environment variable
   - Run `flutter doctor` to verify

3. **"Gradle build failed"**:
   - Clean the project: `flutter clean`
   - Get dependencies again: `flutter pub get`
   - Try building again

4. **"Permission denied" on Android**:
   - Enable Developer Options on your device
   - Enable USB Debugging
   - Accept the debugging prompt on your device

### Build Commands Reference:

```bash
# Clean the project
flutter clean

# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Build for specific platform
flutter build apk
flutter build ios  # (requires macOS and Xcode)

# Check for issues
flutter doctor
flutter analyze
```

## Project Structure

```
viral-together-mobile-app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── core/                     # Core services and utilities
│   ├── features/                 # Feature modules
│   │   ├── auth/                # Authentication
│   │   ├── home/                # Home screen
│   │   ├── influencer/          # Influencer features
│   │   ├── location/            # Location services
│   │   └── profile/             # User profile
│   └── ...
├── android/                      # Android-specific files
├── ios/                         # iOS-specific files
├── pubspec.yaml                 # Dependencies
└── README.md                    # Project documentation
```

## API Configuration

The app is configured to connect to the backend API. Update the API base URL in `lib/core/services/api_service.dart`:

```dart
static const String baseUrl = 'http://10.0.2.2:8000'; // For Android emulator
// static const String baseUrl = 'http://localhost:8000'; // For iOS simulator
// static const String baseUrl = 'https://your-api-domain.com'; // For production
```

## Features Implemented

- ✅ User authentication (login/register)
- ✅ Location-based influencer search
- ✅ Influencer profiles and details
- ✅ Search filters and criteria
- ✅ Modern UI with Material Design 3
- ✅ Offline support with mock data
- ✅ Google Maps integration
- ✅ Responsive design

## Missing Endpoints (Using Mock Data)

The following API endpoints are not implemented in the backend and use mock data:

1. **Influencer Search by Criteria** - Uses mock influencer data
2. **Influencer Details** - Uses mock detailed profiles
3. **Countries List** - Uses mock country data
4. **Regions List** - Uses mock region data

## Next Steps

1. **Backend Integration**: Implement missing API endpoints
2. **Google Maps API Key**: Add your API key for full map functionality
3. **Push Notifications**: Add notification support
4. **Image Upload**: Implement profile picture upload
5. **Payment Integration**: Add payment processing
6. **Analytics**: Add user analytics and tracking

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Run `flutter doctor` to identify setup issues
3. Check Flutter documentation: https://flutter.dev/docs
4. Review the project README.md for additional information 