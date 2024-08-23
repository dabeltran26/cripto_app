# Cripto App

## Necessary facilities
This app needs the following requirements to be able to run.

- `flutter version - 3.22.3`

## Local Installation

initially download the flutter sdk from the following [path](https://docs.flutter.dev/get-started/install/macos)

then update de PATH:
````
export PATH="$PATH:`pwd`/flutter/bin"
````

Run `flutter doctor` to check that it has been installed correctly.

you can use the editor of your choice such as:
- [visual studio code](https://code.visualstudio.com/download)
- [Android Studio](https://developer.android.com/studio)
- [IntelliJ](https://www.jetbrains.com/es-es/idea/download/?section=mac)

In case of using macbook you must download xcode from the app store.

## Running the application

You can run the application on an emulator or on a physical device, to use it on android emulator you must have android studio installed and from there create the emulator, to emulate on iphone you must compile on a macbook and configure the emulator in xcode.

To run on physical device put the cell phone in [debug](https://developer.android.com/studio/debug/dev-options?hl=es-419) mode and then connect it to pc.

Having the above ready we now proceed to compile the project.

Run in the terminal :

````
flutter pub get
````

````
flutter pub run build_runner build --delete-conflicting-outputs
````

````
flutter run
````