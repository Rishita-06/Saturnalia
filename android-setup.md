# Firebase Setup for Flutter App Using FlutterFire CLI

This guide provides step-by-step instructions for integrating Firebase with your Flutter app using the FlutterFire CLI.

## Prerequisites

- Flutter installed on your machine (version 2.0 or higher)
- Firebase account
- Basic understanding of Flutter and Dart
- Node.js and npm installed

## Step 1: Install FlutterFire CLI

1. Open your terminal.
2. Install the FlutterFire CLI globally by running:
   ```sh
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```

## Step 2: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click on "Add Project" and follow the on-screen instructions to create a new project.
3. Once the project is created, click on the project to enter its dashboard.

## Step 3: Configure Firebase in Your Flutter Project

1. Open your Flutter project directory in the terminal.
2. Run the following command to configure Firebase:
   ```sh
   flutterfire configure
   ```
3. Follow the prompts to select your Firebase project and platforms (Android and iOS).
4. The FlutterFire CLI will automatically generate the necessary Firebase configuration files (`google-services.json` for Android and `GoogleService-Info.plist` for iOS) and update your `pubspec.yaml` with the required dependencies.

## Step 4: Add Firebase Services

### Firebase Authentication

Enable Authentication in the Firebase Console:

- Go to the Firebase Console.
- Select "Authentication" from the left sidebar.
- Click on the "Get Started" button.
- Enable the "sign in with google".
- Add SHA key in project settings.(You can generate your SHA key by following steps).

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

## Troubleshooting

- Ensure all configurations are correctly set in the generated files.
- If you encounter any issues, refer to the [Firebase for Flutter Codelab](https://firebase.google.com/codelabs/firebase-get-to-know-flutter) and the official [FlutterFire documentation](https://firebase.flutter.dev/docs/overview).

## Conclusion

By following these steps, you should have successfully set up Firebase in your Flutter app using the FlutterFire CLI. You can now start using flutter app and start working on issues.
