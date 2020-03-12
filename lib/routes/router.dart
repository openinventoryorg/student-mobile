/// Router base class which handles page routing
library router;

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  /// Facotory required to create the singleton.
  factory AppRouter() {
    return _instance ??= AppRouter._internal();
  }

  /// Private contructor required to make creation
  /// of this object restrivted to others.
  AppRouter._internal() {
    _router = Router();
  }

  /// Static object reference the initialized router.
  static AppRouter _instance;

  /// Fluro router reference which handles routing.
  Router _router = Router();

  /// Route generation method.
  ///
  /// It is used with the [MaterialApp.onGenerateRoute] property as callback
  /// to create routes that can be used with the [Navigator] class.
  static RouteFactory get generator => AppRouter()._router.generator;

  /// Fluro router reference which handles routing.
  static Router get _fluroRouter => AppRouter()._router;

  /// Defines a route to a page.
  ///
  /// Example:
  /// ```dart
  /// router.defineRoute(path: "/", handler: (context, params) => HomePage());
  /// ```
  /// Params can be used to get paramters passed to the route.
  void defineRoute({
    @required String path,
    @required HandlerFunc handler,
  }) {
    _router.define(
      path,
      handler: Handler(
        handlerFunc: handler,
        type: HandlerType.route,
      ),
    );
  }

  /// Defines a route to a function(eg: `showDialog`).
  void defineFunction({
    @required String path,
    @required HandlerFunc handler,
  }) {
    _router.define(
      path,
      handler: Handler(
        handlerFunc: handler,
        type: HandlerType.function,
      ),
    );
  }

  /// Navigates to the route.
  static Future<dynamic> navigate(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      TransitionType transition}) {
    return _fluroRouter.navigateTo(
      context,
      path,
      transition: transition ?? TransitionType.cupertino,
      replace: replace ?? false,
      clearStack: clearStack ?? false,
    );
  }

  /// Navigates to route after emptieing the stack.
  static Future<dynamic> freshNavigate(BuildContext context, String path) {
    return _fluroRouter.navigateTo(
      context,
      path,
      transition: TransitionType.fadeIn,
      replace: true,
      clearStack: true,
    );
  }

  /// Navigate to route by giving the builder callback instead of route string.
  static Future<T> directNavigate<T>(
      BuildContext context, WidgetBuilder callback) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => callback(_),
      ),
    );
  }
}
