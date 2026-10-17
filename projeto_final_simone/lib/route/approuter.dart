import 'package:go_router/go_router.dart';
import '../model/diasemana.dart';
import '../view/splashscreen.dart';
import '../view/homescreen.dart';
import '../view/detalhescreen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'monitor/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final diaTexto = state.uri.queryParameters['dia'];
            final dia =
                diaTexto == null ? null : DiaSemana.fromString(diaTexto);
            return DetalheScreen(monitorId: id, dia: dia);
          },
        ),
      ],
    ),
  ],
);
