# AMS-FRONTEND
Attendence Management System

# CREATE A FLUTTER PROJECT
 - flutter create <projectname>


# LETS CONNECT OUR FLUTTER APP WITH FIREBASE
 - need first to create a project in firebase 
 - pub get firebase_core dependency
 - install [npm install -g firebase-tools] 
 - Log into Firebase using your Google account - [firebase login]
 - Install the FlutterFire CLI [dart pub global activate flutterfire_cli]
 - creates firebase_options file in lib dir
 
 - appIds  
[
web       1:516152774492:web:5c64da4fc801a9593ebb99
android   1:516152774492:android:4bec450075b52bfe3ebb99
ios    1:516152774492:ios:e501362afeb1dcbb3ebb99
]

 or
- flutter create --org com.yourdomain your_app_name
  exp -> flutter create --org com.example.amsystm amsystm

# MAKE FOLDERS TO FOLLOW SOLID PRINCIPLES


# NOW LETS ADD SPLASH SCREEN FIRST TO GIVE A LOOK BEFORE THE APP STARTS
  - create a file called flutter_native_splash.yaml in root dir.
  - add in pubspec.yam file 
      dependencies:
  flutter:
    sdk: flutter
  flutter_native_splash: ^2.2.19

  flutter_native_splash:
    android: true
    ios: true
    web: true
    color: "#024959"
    image: "img/SplashScreen.png"
  - run 
    flutter clean
    flutter pub get
    flutter dart run flutter_native_splash:create
