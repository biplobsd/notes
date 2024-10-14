import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/pages/home_page.dart';
import 'package:notes/layers/presentation/pages/login_page.dart';

final gorouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: '/login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    )
  ],
);
