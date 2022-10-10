import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/pages.dart';

import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        name: 'main_page',
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
              path: 'profile/:name',
              name: 'profile',
              builder: (context, state) {
                String name = state.params['name'] ?? 'no name';
                return ProfilePage(name: name);
              },
              routes: [
                GoRoute(
                  path: 'edit_profile',
                  name: 'edit_profile',
                  builder: (context, state) {
                    Object? object = state.extra;

                    if (object != null && object is User) {
                      return EditProfilePage(user: object);
                    } else {
                      return const EditProfilePage(
                          user: User('no name', 'no email'));
                    }
                  },
                )
              ]),
        ],
      ),
    ],
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routerNeglect: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
