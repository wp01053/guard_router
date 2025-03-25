library guard_router;

import 'package:flutter/material.dart';
import 'package:guard_router/dialog_guard_wrapper.dart';

import 'guard_router.dart';

export 'package:go_router/go_router.dart'; // go_router

extension GuardRoute on GoRoute {
  // Converts existing GoRoute to GoRoute with authentication check function.
  GoRoute withPageGuard({
    required bool Function() isChecked,
    required String redirectRoute,
  }) {
    return GoRoute(
      path: path,
      name: name,
      // redirect
      redirect: (BuildContext context, GoRouterState state) {
        if (!isChecked()) {
          return redirectRoute;
        }
        return null;
      },
      builder: builder,
      routes: routes,
    );
  }
}

// withDialogGuard 확장 메서드
extension DialogGuardRoute on GoRoute {
  GoRoute withDialogGuard({
    required bool Function() isChecked,
    required Future<bool> Function(BuildContext) showDialogGuard,
  }) {
    return GoRoute(
      path: path,
      name: name,
      builder:
          (context, state) => DialogGuardWrapper(
            isChecked: isChecked,
            showDialogGuard: showDialogGuard,
            child: builder?.call(context, state) ?? const SizedBox.shrink(),
          ),
      routes: routes,
    );
  }
}
