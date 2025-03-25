import 'package:flutter/material.dart';
import 'package:guard_router/guard_router.dart';

void main() {
  runApp(MyApp());
}

// As an example, always return false to assume that you are not logged in.
bool checkLoginStatus() {
  return false;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Go_router Settings: Add a Guard for each path.
  final GoRouter _router = GoRouter(
    routes: [
      // Home screen: use without any guard
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      // Page requiring login: using withAuthGuard
      GoRoute(
        path: '/protected',
        builder: (context, state) => const ProtectedPage(),
      ).withPageGuard(
        isChecked: () => checkLoginStatus(),
        redirectRoute: '/login',
      ),
      // Page that needs to be checked with dialog: Using withDialogGuard
      GoRoute(
        path: '/dialog-protected',
        builder: (context, state) => const DialogProtectedPage(),
      ).withDialogGuard(
        isChecked: () => checkLoginStatus(),
        showDialogGuard: (context) async {
          // If you are not logged in, pop up a dialog and wait for your choice
          final result = await showDialog<bool>(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Login required'),
                  content: const Text(
                    'You need to log in. Do you want to log in?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
          );
          // Return to page if true, return to previous screen if false
          return result ?? false;
        },
      ),
      // Login Page
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Auto Guard Router Demo',
      routerConfig: _router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/protected');
              },
              child: const Text('Login Required Page (AuthGuard)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push('/dialog-protected');
              },
              child: const Text('Check Dialogue page (DialogGuard)'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProtectedPage extends StatelessWidget {
  const ProtectedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protected Page')),
      body: const Center(
        child: Text('This page is accessible after logging in.'),
      ),
    );
  }
}

class DialogProtectedPage extends StatelessWidget {
  const DialogProtectedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Protected Page')),
      body: const Center(
        child: Text('This is an accessible page after checking the Dialog.'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // In the actual app, after processing the login logic, update the status and return to the original page.
            // Here, as an example, go to the home screen.
            context.push('/');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
