# Firebase Setup for Flutter App Using FlutterFire CLI (macOS)

This guide provides step-by-step instructions for integrating Firebase with your Flutter app using the FlutterFire CLI on macOS.

## Prerequisites

- Flutter installed on your macOS machine (version 2.0 or higher)
- Firebase account
- Basic understanding of Flutter and Dart
- Homebrew (for managing Node.js installation)
- Node.js and npm installed

## Step 1: Install Homebrew (if not already installed)

1. Open your Terminal.
2. Install Homebrew by running the following command:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Follow the on-screen instructions to complete the installation.

## Step 2: Install Node.js and npm

1. Use Homebrew to install Node.js and npm:
   ```sh
   brew install node
   ```

## Step 3: Install FlutterFire CLI

1. Open your Terminal.
2. Install the Firebase CLI globally by running:
   ```sh
   npm install -g firebase-tools
   ```
3. Install the FlutterFire CLI globally by running:
   ```sh
   dart pub global activate flutterfire_cli
   ```

## Step 4: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click on "Add Project" and follow the on-screen instructions to create a new project.
3. Once the project is created, click on the project to enter its dashboard.

## Step 5: Configure Firebase in Your Flutter Project

1. Open your Flutter project directory in the Terminal.
2. Run the following command to configure Firebase:
   ```sh
   flutterfire configure
   ```
3. Follow the prompts to select your Firebase project and platforms (Android and iOS).
4. The FlutterFire CLI will automatically generate the necessary Firebase configuration files (`google-services.json` for Android and `GoogleService-Info.plist` for iOS) and update your `pubspec.yaml` with the required dependencies.

## Step 6: Run Your Flutter App

1. Connect your device or start an emulator.
2. Run `flutter run` in the Terminal.
3. Your Flutter app should now be successfully connected to Firebase.

## Step 7: Add Firebase Services

### Firebase Authentication

Enable Authentication in the Firebase Console:

- Go to the Firebase Console.
- Select "Authentication" from the left sidebar.
- Click on the "Get Started" button.
- Enable sign in with google.
- Copy the CLIENT_ID from your `GoogleService-Info.plist`(generated in `ios\runner`) and paste in `lib\src\logic\services\firebase_auth.dart` in place of `{CLIENT_ID}`.
- Copy the REVERSED_CLIENT_ID from `GoogleService-Info.plist`(generated in `ios\runner`) and paste in `ios\runner\Info.plist` in place of `{REVERSED_CLIENT_ID}`.

### Firestore Database

Enable Firestore in the Firebase Console:

- Go to the Firebase Console.
- Select "Firestore Database" from the left sidebar.
- Click on the "Create Database" button.
- Follow the prompts to set up your Firestore database.

### Firestore Storage

Enable Firestore Storage in the Firebase Console:

- Go to the Firebase Console.
- Select "Storage" from the left sidebar.
- Click on the "Get Started" button.
- Follow the prompts to set up your Storage.

## IMPORTANT

## Troubleshooting

- Ensure all configurations are correctly set in the generated files.
- If you encounter any issues, refer to the [Firebase for Flutter Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter) and the official [FlutterFire documentation](https://firebase.flutter.dev/docs/overview).

## Conclusion

By following these steps, you should have successfully set up Firebase in your Flutter app using the FlutterFire CLI. You can now start using flutter app and start working on issues.
