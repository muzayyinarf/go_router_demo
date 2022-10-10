import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_demo/bloc/user_bloc.dart';
import 'package:go_router_demo/pages.dart';

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
              path: 'profile',
              name: 'profile',
              builder: (context, state) {
                return const ProfilePage();
              },
              routes: [
                GoRoute(
                  path: 'edit_profile',
                  name: 'edit_profile',
                  builder: (context, state) {
                    return const EditProfilePage();
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
    return BlocProvider(
      create: (context) => UserBloc()..add(CheckSignInStatus()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSignedIn) {
            router.goNamed('main_page');
          } else if (state is UserSignedOut) {
            router.goNamed('login');
          }
        },
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
