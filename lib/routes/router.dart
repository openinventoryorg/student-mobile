import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouter {
  /// Generator factory
  factory AppRouter() {
    return _instance ??= AppRouter._internal();
  }

  /// Private contructor
  AppRouter._internal() {
    _router = Router();
  }

  /// Static object reference
  static AppRouter _instance;

  /// Fluro router reference
  Router _router = Router();

  /// Getters
  static RouteFactory get generator => AppRouter()._router.generator;
  static Router get _fluroRouter => AppRouter()._router;

  /// Define a route to a page
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

  /// Define a route to a function(eg: `showDialog`)
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

  /// Navigate to the route
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

  /// Navigate to route. But first empty the stack.
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
