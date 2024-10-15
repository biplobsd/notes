import 'package:go_router/go_router.dart';
import 'package:notes/layers/presentation/pages/home_page.dart';
import 'package:notes/layers/presentation/pages/login_page.dart';
import 'package:notes/layers/presentation/pages/note_form_page.dart';
import 'package:notes/layers/presentation/pages/registration_page.dart';
import 'package:notes/layers/presentation/pages/splash_page.dart';

final gorouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: '/splash',
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: '/login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: '/register',
      path: '/register',
      builder: (context, state) => const RegistrationPage(),
    ),
    GoRoute(
      name: '/',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/note',
      name: '/note',
      builder: (context, state) {
        final noteId = state.uri.queryParameters['noteId'];
        final title = state.uri.queryParameters['title'];
        final description = state.uri.queryParameters['description'];

        return NoteFormPage(
          noteId: noteId,
          initialTitle: title,
          initialDescription: description,
        );
      },
    )
  ],
);
