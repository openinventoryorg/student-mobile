import 'dart:convert';

import 'package:colorize/colorize.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:openinventory_student_app/api/responses/token.dart';

import 'package:openinventory_student_app/main.dart';
import 'package:openinventory_student_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends Mock implements http.Client {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockDioAdapter extends Mock implements HttpClientAdapter {}

void printh(String string) {
  color(string, back: Styles.BG_GREEN, front: Styles.BLACK);
}

void prints(String string) {
  color('\t$string', front: Styles.GREEN);
}

/// Integration test for login flow.
/// Connects to a mock api instead of real api.
void main() {
  testWidgets('Staff flow test', (tester) async {
    printh('Staff flow test');

    defineAllRoutes();
    SharedPreferences.setMockInitialValues({
      "url": "http://mock.com",
      "token": jsonEncode(TokenResponse(
        token: "TOKEN",
        user: UserResponse(
            id: "ID",
            email: "user@mock.com",
            firstName: "User",
            lastName: "User",
            permissions: ["REQUESTER"],
            role: "administrator",
            roleId: "ROLEID"),
      ).toJson())
    });

    // Start app
    var mockNavigatorOb = MockNavigatorObserver();
    var mockDio = Dio();
    await tester.pumpWidget(App(
      navigatorObservers: [mockNavigatorOb],
      dio: mockDio,
    ));
    await tester.pumpAndSettle();

    // Ensure that '/' and '/home' are pushed
    List pushedRoutesList =
        verify(mockNavigatorOb.didPush(captureAny, any)).captured;
    var pushedRoutes = List<PageRoute>.from(pushedRoutesList);
    expect(pushedRoutes[0].settings.name, equals("/"));
    expect(pushedRoutes[1].settings.name, equals("/staff"));
    prints('1. Splash screen will automatically navigate to home page.');

    // Verify page
    expect(find.text('Temperory Handover'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    prints('2. Staff page grid items found.');
  });
}
