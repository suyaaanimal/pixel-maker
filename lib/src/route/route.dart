import 'package:go_router/go_router.dart';
import 'package:pixel_maker/src/page/edit/edit_screen.dart';
import 'package:pixel_maker/src/page/home_screen.dart';

final route = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: ((context, state) => HomeScreen(
            key: state.pageKey,
          ))),
  GoRoute(
      path: '/edit',
      builder: ((context, state) => EditScreen(
            key: state.pageKey,
          )))
]);
