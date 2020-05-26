/// Defines routes used in the app
library router_routes;

import 'package:openinventory_student_app/views/pages/form.dart';
import 'package:openinventory_student_app/views/pages/home.dart';
import 'package:openinventory_student_app/views/pages/item.dart';
import 'package:openinventory_student_app/views/pages/lab.dart';
import 'package:openinventory_student_app/views/pages/login.dart';
import 'package:openinventory_student_app/views/pages/splash.dart';
import 'package:openinventory_student_app/views/pages/staff/home.dart';
import 'package:openinventory_student_app/views/pages/staff/profile.dart';
import 'package:openinventory_student_app/views/pages/staff/handover.dart';

import 'router.dart';

/// List of routes in the app
void defineAllRoutes() {
  AppRouter router = AppRouter();
  router.defineRoute(path: "/", handler: (_, __) => SplashScreen());
  router.defineRoute(path: "/home", handler: (_, __) => HomePage());
  router.defineRoute(path: "/login", handler: (_, __) => LoginPage());
  router.defineRoute(path: "/profile", handler: (_, __) => ProfilePage());
  router.defineRoute(path: "/staff", handler: (_, __) => StaffHomePage());
  router.defineRoute(
      path: "/staff/temp", handler: (_, __) => TemperoryHandover());
  router.defineRoute(
      path: "/home/lab/:id",
      handler: (_, params) => LabPage(id: params['id'][0]));
  router.defineRoute(
      path: "/item/:id", handler: (_, params) => ItemPage(id: params['id'][0]));
  router.defineRoute(
      path: "/lend/:id", handler: (_, params) => LendForm(id: params['id'][0]));
}
