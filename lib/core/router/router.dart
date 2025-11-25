import 'package:go_router/go_router.dart';
import 'package:portfolio/shared/widgets/main_layout.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => const MainLayout())],
);
