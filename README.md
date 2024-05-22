**# A Movie Catalog App**
![Home Page](assets/images/ex1.png) ![Detail Page](assets/images/ex2.png)

<table>
  <tr>
    <td>Home Screen </td>
     <td>Detail Screen</td>
    
  </tr>
  <tr>
    <td><img src="assets/images/ex1.png" width=270 height=480 alt=""></td>
    <td><img src="assets/images/ex2.png" width=270 height=480 alt=""></td>
    
  </tr>
 </table>


**# Flutter GetX Template with GetCLI**

**## GetX, Rest Api, GraphQL Api, FirebaseCLI, Hive,** 

Flutter Getx template to make starting project fast and easy
.

## **Feature**

- Every packages are up to date
- Rest api requests & error handling with app state
- GraphQL api requests & error handling with app state
- Hive for offline Caching
- Shared preference custom class
- Snackbar,Toasts & in app notifications 
- FCM and Push notifications with Flutter Local Notification custom class
- Custom Image Picker with Cropper class
- Web Socket Manager class
- Theme (light/dark) & store current theme in shared pref
- Localization & store the current locale in shared pref
- Making app more responsive and stop font scaling 
  This project will take care of all this repeatable things so you can start your project in few steps and you will have all the mentioned points set up and ready to use 


## **Clone and start project**
Before discovering folders lets first perform some actions to make the project ready to launch

- To run in iOS you must have installed cocoapods in your mac , Let's delete Pods folder and Podfile.lock and run
  ```
  flutter clean
  ```
  ```
  flutter pub get
  ```
  ```
  cd ios
  ```
  ```
  pod install
  ```
  ```
  cd..
  ```
  
- To make your app responsive and look exactly as your (xd,figma..etc) design you need to set artbord size for flutter_ScreenUtil in main.dart
    ```dart
    ScreenUtilInit(
      designSize: const Size(375, 812), // change this to your xd/Figma artboard size
    ```


- Change app package name
    ```
    flutter pub run change_app_package_name:main com.new.package.name
    ```
  - Change app name
    ```
    flutter pub run rename_app:main all="My App Name"
    ```
  
- Change app launch icon (replace assets/images/app_icon.png with your app icon) then run this command
    ```
    flutter pub run flutter_launcher_icons:main
    ```
- Change app splash screen (replace assets/images/splash.png with your app splash logo) then run this command
   ```
   flutter pub run flutter_native_splash:create
   ```
- FCM: firebase has recently added (add flutter app) to your firebase which will make adding our flutter(android/ios) app to firebase take only 2 steps 🔥 but first you need to download [Firebase CLI](https://firebase.google.com/docs/cli?authuser=0&hl=en#install_the_firebase_cli) and in the terminal execute:
    ```
    dart pub global activate flutterfire_cli
    ```
  then follow the firebase guid you will get command similar to this one
    ```
    flutterfire configure --project=flutter-firebase-YOUR_PROJECT_ID
    ```
  and that's it! your project is now connected to firebase and fcm is up and ready to get notifications
  ##### Important Note
  IOS require few more steps from your side to recive fcm notifications follow the [Dcos](https://firebase.flutter.dev/docs/messaging/apple-integration/) steps and after that everything should be working fine from flutter side
## Quick Start
- Responsive app: to make your app responsive you need to get advantage of using flutter_ScreenUtil so instead of using normal double values for height,width,radius..etc you need to use it like this
-
```dart
200.w // adapted to screen width
100.h // /Adapted to screen height
25.sp // adapter font size
10.r // adapter radius
// Example
Container(
    height: 100.h,
    width: 200.w,
    child: Text("Hello",style: TextStyle(fontSize: 20.sp,))
)
```

- Theme
    - Change theme

        ```dart
        MyTheme.changeTheme();
        ```

    - Check current theme

        ```dart
        bool isThemeLight = MyTheme.getThemeIsLight();
        ```

- Localization
    - Change app locale

        ```dart
        LocalizationService.updateLanguage('en');
        ```

    - Get current locale

        ```dart
        LocalizationService.getCurrentLocal();
        ```

    - Use translation

        ```dart
        Text(Strings.hello.tr)
        ```


## Discovering Project
After setting up all the needed thing now lets talk about folder structure which is mainly based on Getx Pattern and there are some personal opinions, if you open your lib folder you will find those folders

```
.
└── lib
    ├── app
    │   ├── components
    │   ├── data
    │   │   ├── local
    │   │   └── models
    │   ├── modules
    │   │   └── home
    │   ├── routes
    │   └── services
    ├── config
    │   ├── theme
    │   └── translation
    └── utils
```

- app: will contain all our core app logic
    - components: will contain all the shared UI widgets
    - data: will contain our models and local data sources (local db & shared pref)
    - modules: app screens
    - routes: generated by get_cli and it will contain our navigation routes
    - services: contain all logic for making safe & clean api calls
- config: will contain app config such as themes, localization services
- utils: for our helper classes
## Features
- Theme: if you opened theme package you will see those files

    ```
    └── theme
        ├── dark_theme_colors.dart
        ├── light_theme_colors.dart
        ├── my_fonts.dart
        ├── my_styles.dart
        └── my_theme.dart
   
    ```

  you only need to change app colors (light/dark_theme_colors) and if you want to change app fonts sizes and family just modify my_fonts.dart and that is it you don't need to worry about styles and theme you only need to edit my_syles.dart if you want to change some element theme data (padding,border..etc) and if you want to change theme just use this code

    ```dart
    // change theme and save current theme state to shared pref
    MyTheme.changeTheme();
    ```

  and if you want to check if the theme is dark/light just use
    ```dart
    bool themeIsLight = MyTheme.getThemeIsLight();
    // OR
    bool themeIsLight = MySharedPref.getThemeIsLight();
    ```
- Localization/translation we will use getx localization system which in the normal case code would look something like this

    ```dart
    class LocalizationService extends Translations {
        @override
        Map<String, Map<String, String>> get keys => {
            'en_US': { 'hello' : 'Hello' },
            'ar_AR': { 'hello' : 'مرحباً' },
        };
    }

    Text('hello'.tr); // translated text 
  ```

  but because we have so many words to translate we will separate keys file (strings_enum.dart) and languages map into different classes so code will become like this

  ```dart
  class LocalizationService extends Translations {
        @override
        Map<String, Map<String, String>> get keys => {
            'en_US': enUs,
            'ar_AR': arAR,
        };
    }
  // keys
  class Strings {
      static const String hello = 'hello';
  }
  // english words
  const Map<String, String> enUs = {
      Strings.hello : 'Hello',
  }
  // arabic translate
  final Map<String, String> arAR = {
      Strings.hello : 'مرحبا',
  }
  //result
  Text(Strings.hello.tr)
  ```

  and that explain why we have this file structure inside our translation package

     ```
        └── translations
            ├── ar_Ar
            │   └── ar_ar_translation.dart
            ├── en_US
            │   └── en_us_translation.dart
            ├── localization_service.dart
            └── strings_enum.dart
     ```

  to change language you will use

    ```dart
    LocalizationService.updateLanguage('en');
    ```

  and to get the current locale/language you can use

    ```dart
    LocalizationService.getCurrentLocal();
    // OR
    MySharedPref.getCurrentLocal();
    ```


## Support

For support, email mirmoktadir@gmail.com 
Facebook  [Mir Moktadir](https://www.facebook.com/moktadir91/) 
LinkedIn [Mir Moktadir](https://www.linkedin.com/in/mir-moktadir-bb144290/)
Phone no: +8801701308477 (Whatsapp or Telegram)

