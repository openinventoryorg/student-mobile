import 'package:openinventory_student_app/views/browse_page/lab_page/lab_page.dart';

import '../splash.dart';
import '../views/home_page.dart';
import '../views/login_page/login_page.dart';

import 'router.dart';

/// List of routes in the app
void defineAllRoutes() {
  AppRouter router = AppRouter();
  router.defineRoute(path: "/", handler: (_, __) => SplashScreen());
  router.defineRoute(path: "/home", handler: (_, __) => HomePage());
  router.defineRoute(path: "/login", handler: (_, __) => LoginPage());
  router.defineRoute(
      path: "/home/lab/:id",
      handler: (_, params) => LabPage(id: params['id'][0]));
}
