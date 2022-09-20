import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/page/edit/edit_screen.dart';
import 'package:pixel_maker/src/page/home_screen.dart';
import 'package:pixel_maker/src/page/settings/login.dart';
import 'package:pixel_maker/src/page/settings/setting.dart';

final route = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        builder: ((context, state) => HomeScreen(
              key: state.pageKey,
            )),
        routes: [
          GoRoute(
              path: 'edit',
              builder: ((context, state) => EditScreen(
                    key: state.pageKey,
                  ))),
          GoRoute(
              path: 'settings',
              builder: ((context, state) => SettingsScreen(
                    key: state.pageKey,
                  )),
              routes: [
                GoRoute(
                    path: 'login',
                    builder: ((context, state) => LoginScreen(
                          key: state.pageKey,
                        ))),
              ]),
        ])
  ],
  refreshListenable:
      GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  redirect: ((state) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null && state.subloc != '/settings/login') {
      return '/settings/login';
    } else if (user != null && state.subloc == '/settings/login') {
      return '/';
    }
    return null;
  }),
);
