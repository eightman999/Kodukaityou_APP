# Kodukaityou

Kodukaityou (小遣い帳) is an iOS application for managing your budget and expenses. The project is written in Swift and uses CocoaPods to manage its dependencies.

## Requirements

- Xcode 15 or later
- CocoaPods 1.11 or later
- iOS 15.0 or later (tested on iOS 17)

## Setup

1. Install CocoaPods if it is not installed:

   ```bash
   sudo gem install cocoapods
   ```

2. Install the dependencies:

   ```bash
   pod install
   ```

3. Open the generated `KOZUKAITYOU.xcworkspace` in Xcode:

   ```bash
   open KOZUKAITYOU.xcworkspace
   ```

4. Select a device running iOS 15 or later and build the project.

The repository already includes a `GoogleService-Info.plist` file for Firebase configuration. If you wish to use your own Firebase project, replace this file with one generated from the Firebase console.

## Features

- Expense input screens with Realm database storage
- Charts for visualizing spending
- Support for Firebase Analytics and FirebaseUI authentication
- UI utilities such as IQKeyboardManager and SVProgressHUD

## License

This project is provided as-is without warranty. See individual CocoaPods for their respective licenses.
