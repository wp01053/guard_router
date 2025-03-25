# guard_router

guard_router is a Flutter package that extends the functionality of [go_router](https://pub.dev/packages/go_router) by adding easy-to-use route guards. With guard_router, you can quickly implement authentication checks and conditional navigation without writing extra boilerplate code.

## Features

- **Page Guard:** Easily protect routes with authentication checks or other conditions. If the condition fails, the user is redirected to a specified route.
- **Dialog Guard:** Display a dialog before navigating to certain routes. Based on the user's response, navigation is either allowed or cancelled.
- **Seamless Integration:** Re-export go_router's API so you can use all of go_router’s features alongside the added guard functionality.

## Getting Started

### Installation

Add guard_router as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  guard_router: ^x.y.z
```

Replace `^x.y.z` with the latest version of the package, then run:

```bash
flutter pub get
```

### Usage

Import guard_router in your Dart code:

```dart
import 'package:guard_router/guard_router.dart';
```

#### Page Guard Example

Protect a route by using the withAuthGuard extension. For example, redirect users to the login page if they are not authenticated:

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/protected',
      builder: (context, state) => ProtectedPage(),
    ).withAuthGuard(
      isLoggedIn: () => checkLoginStatus(), // Your authentication check function
      loginRoute: '/login',
    ),
  ],
);
```

In this example, if `checkLoginStatus()` returns false, the user is redirected to the `/login` route.

#### Dialog Guard Example

Prompt the user with a confirmation dialog when trying to access a route using the withDialogGuard extension:

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/dialog-protected',
      builder: (context, state) => DialogProtectedPage(),
    ).withDialogGuard(
      isChecked: () => checkCondition(), // Your condition check function
      showDialogGuard: (context) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation Required'),
            content: const Text('Do you wish to proceed?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Proceed'),
              ),
            ],
          ),
        ) ?? false;
      },
    ),
  ],
);
```

If `checkCondition()` returns false, the dialog appears. Based on the user's choice (true to proceed, false to cancel), navigation will continue or be halted.

#### Example App

A complete example demonstrating how to use guard_router is available in the `example/` directory of this repository. To run the example, execute:

```bash
flutter run
```

#### Contributing

Contributions are welcome! If you have suggestions, bug reports, or improvements, please open an issue or submit a pull request.

#### License

This project is licensed under the MIT License. See the LICENSE file for details.
