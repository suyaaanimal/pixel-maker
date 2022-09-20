import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/page/edit/edit_new_screen/edit_new_provieder.dart';
import 'package:pixel_maker/src/page/edit/edit_new_screen/edit_new_screen.dart';
import 'package:pixel_maker/src/page/edit/edit_update_screen.dart';
import 'package:pixel_maker/src/page/home_screen.dart';
import 'package:pixel_maker/src/page/settings/init_user.dart';
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
              builder: ((context, state) => EditUpdateScreen(
                    key: state.pageKey,
                    size: int.tryParse(state.queryParams['size'] ?? ''),
                    pixels: state.extra as List<List<Color>>?,
                    docId: state.queryParams['docId'],
                  )),
              routes: [
                GoRoute(
                    path: 'new',
                    builder: (context, state) => EditNewProvider(
                          size: int.parse(state.queryParams['size'] ?? '16'),
                          key: state.pageKey,
                        ),
                    routes: [
                      GoRoute(
                          path: 'settings',
                          builder: ((context, state) => EditCreateScreen(
                                key: state.pageKey,
                              )))
                    ]),
              ]),
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
                GoRoute(
                    path: 'init_user',
                    builder: (((context, state) => InitUserScreen(
                          key: state.pageKey,
                        ))))
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
