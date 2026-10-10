# Dual Tap

A fun and competitive Flutter-based tap game where two players battle to conquer the screen by tapping their respective colored areas. The player who fills the entire screen first wins!

## Features

- **Two-Player Gameplay**: Player A (Red) vs Player B (Blue) in a head-to-head competition
- **Real-time Area Expansion**: Tap to expand your territory and shrink your opponent's
- **Score Tracking**: Points awarded for each tap, displayed in real-time
- **Victory Detection**: Automatic win detection when a player fills the entire screen
- **Restart Functionality**: Easy restart to play again
- **Sound Effects**: Audio feedback for taps and victory celebrations
- **Cross-Platform**: Runs on Android, iOS, Web, Linux, Windows, and macOS
- **Custom Splash Screen**: Branded splash screen for all platforms
- **Adaptive App Icons**: Platform-specific launcher icons

## Game Rules

1. The screen is divided into two halves: top (Blue - Player B) and bottom (Red - Player A)
2. Players tap their respective areas to expand their territory
3. Each tap moves the territory divider by 4% and awards 5 points
4. The first player to fill the entire screen wins
5. Scores are tracked and displayed during gameplay

## Screenshots

*(Add screenshots here when available)*

## Requirements

### System Requirements

- Flutter SDK: 3.47.0 stable
- Dart SDK: Included with Flutter

### Development Environment
- Android Studio or VS Code with Flutter extension
- For Android development: Android SDK (API level 21 or higher)
- For iOS development: macOS with Xcode
- For Web development: Chrome browser

### App Identity and Versioning

- Android application ID: `com.naveed.dualtap`
- iOS bundle identifier: `com.naveed.dualtap`
- Version source: `pubspec.yaml`, currently `1.0.0+1`
- The build name is the semantic version (`1.0.0`); the build number is the incrementing release number (`1`)

Update the `version:` value before each release. Create a matching tag, for example:

```bash
git tag v1.0.0+1
git push origin v1.0.0+1
```

The tag starts the GitHub Actions release workflow. It produces an Android App Bundle and an iOS app artifact. Store publishing still requires your Google Play and Apple Developer credentials configured as repository secrets.

### Dependencies
- `flutter`: The Flutter framework
- `cupertino_icons`: iOS-style icons
- `flutter_native_splash`: Custom splash screen generation
- `flutter_launcher_icons`: App icon generation
- `audioplayers`: Audio playback for sound effects
- `flutter_lints`: Code linting rules

## Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd tap_game
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Add sound files** (optional):
   Place the following audio files in `assets/audio/`:
   - `notification-alert-sound.mp3`: Sound effect for button taps
   - `victory.mp3`: Sound effect for victory

   **Note**: Placeholder files are created. Replace them with actual MP3 sound files for audio feedback. If audio files are not present or invalid, the game will work silently.

## Running the App

### Development Mode
```bash
flutter run
```

### Choose Target Platform
```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d chrome

# Linux
flutter run -d linux

# Windows
flutter run -d windows

# macOS
flutter run -d macos
```

### Debug Mode
```bash
flutter run --debug
```

### Android Release Signing

Never commit a keystore or `android/key.properties`. For a local signed release, create `android/key.properties` with the values expected by `android/app/build.gradle.kts`. The GitHub Actions workflow reads the equivalent values from these secrets:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_STORE_PASSWORD`

Without signing credentials, local debug builds and tests remain available, but the Android artifact is not ready for Play Store submission.

### Production CI/CD

The release workflow is defined in `.github/workflows/release.yml`. It pins Flutter 3.47.0, validates a release tag against `pubspec.yaml`, builds a signed Android App Bundle, and builds an unsigned iOS release artifact on macOS. App Store and Play Store publishing requires configuring the respective store credentials and signing certificates in GitHub Actions secrets.

### Release Build
```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release
```

## Project Structure

```
tap_game/
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── lib/                     # Flutter source code
│   └── main.dart           # Main application file
├── assets/                  # Static assets
│   ├── images/             # Image assets
│   └── audio/              # Audio assets
├── test/                    # Unit tests
├── web/                     # Web-specific files
├── windows/                 # Windows-specific files
├── linux/                   # Linux-specific files
├── macos/                   # macOS-specific files
├── pubspec.yaml            # Project configuration
├── analysis_options.yaml   # Code analysis settings
└── README.md               # This file
```

## Configuration

### Splash Screen
Configured in `pubspec.yaml` under `flutter_native_splash`:
- White background (#ffffff)
- Custom splash image: `assets/images/splash_img.png`
- Enabled for Android, iOS, and Web

### App Icons
Configured in `pubspec.yaml` under `flutter_launcher_icons`:
- Android: `assets/images/android_logo.png`
- iOS: `assets/images/ios_logo.png` (alpha channel removed)
- Web: `assets/images/web_logo.png`
- Adaptive icons for Android

## Development

### Code Style
This project uses `flutter_lints` for code analysis. Run:
```bash
flutter analyze
```

### Testing
Run unit tests:
```bash
flutter test
```

### Building Assets
After changing images or configurations:
```bash
flutter pub run flutter_launcher_icons:main
flutter pub run flutter_native_splash:create
```

## Troubleshooting

### Common Issues

1. **Splash screen not showing**:
   - Ensure images are in `assets/images/` directory
   - Run the generation commands after adding images

2. **Icons not updating**:
   - Clean build: `flutter clean`
   - Regenerate icons: `flutter pub run flutter_launcher_icons:main`

3. **Build failures**:
   - Update dependencies: `flutter pub upgrade`
   - Check Flutter version: `flutter doctor`

4. **Platform-specific issues**:
   - Android: Ensure Android SDK is installed
   - iOS: Requires macOS and Xcode
   - Web: Ensure Chrome is available

### Performance Tips
- The game uses real-time UI updates, so performance depends on device capabilities
- For smooth gameplay, ensure target devices have adequate processing power

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes and test thoroughly
4. Commit your changes: `git commit -am 'Add feature'`
5. Push to the branch: `git push origin feature-name`
6. Submit a pull request

## Future Enhancements

- [x] Sound effects for taps and victory
- [ ] Vibration feedback
- [ ] Multiplayer online mode
- [ ] Different game modes (time-based, score-based)
- [ ] Customizable colors and themes
- [ ] Leaderboards and statistics
- [ ] AI opponent for single-player mode

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Icons generated with [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- Splash screen created with [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

---

**Enjoy the game!** 🎮
