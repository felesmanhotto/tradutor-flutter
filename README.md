# Translator App – Built with Flutter

This is a simple mobile translator app built using Flutter.  
It allows users to translate text between multiple languages with a clean and responsive interface.

## Features

- Translate between:
  - Portuguese 🇧🇷
  - English 🇺🇸
  - Spanish 🇪🇸
  - French 🇫🇷
  - Italian 🇮🇹
  - German 🇩🇪
- Language selection with flags
- Live text translation via [MyMemory API](https://mymemory.translated.net/)
- Copy translated text with one tap
- Error handling with alerts
- Loading indicator while translating

## Requirements

- Flutter SDK (3.10 or higher recommended)
- Android SDK or a physical Android devide

## Project Structure

- `lib/`
  - `main.dart` — Main app code
- `assets/`
  - `English.png`, `Portuguese.png`, ...
- `pubspec.yaml` — Dependencies and asset configuration



## How to Run on a Real Android Device

1. Enable **Developer Options** on your Android phone
   - Settings > About phone > Tap "Build number" several times
   - Enable **USB Debugging**

2. Connect your phone via USB

3. Run this in the project folder:

```bash
flutter devices               # Check if your device is detected and shows it's ID
flutter run -d <device_id>    # Launch the app on your phone

