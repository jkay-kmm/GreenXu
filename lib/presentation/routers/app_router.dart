import 'package:go_router/go_router.dart';
import 'package:greenxu/presentation/pages/splash/splash_screen.dart';
import 'package:greenxu/presentation/pages/option/option_screen.dart';

final GoRouter appRouter = GoRouter(
  routerNeglect: false,
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/option', builder: (context, state) => const OptionScreen()),

    // GoRoute(
    //   path: '/get-started',
    //   builder: (context, state) => const GetStartedPage(),
    // ),
    // GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    // GoRoute(
    //   path: '/register',
    //   builder: (context, state) => const RegisterScreen(),
    // ),
    //
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const AuthGuard(child: HomeScreen()),
    // ),
  ],
);
