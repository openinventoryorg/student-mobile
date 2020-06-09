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
///
/// Connects to a mock api instead of real api.
void main() {
  testWidgets('Sign-in flow test', (tester) async {
    printh('Sign-in flow test');

    defineAllRoutes();
    SharedPreferences.setMockInitialValues({});

    // Setup mock api
    var mockAdapter = MockDioAdapter();
    var tokenResponse = TokenResponse(
      token: "TOKEN",
      user: UserResponse(
        id: "ID",
        email: "user@mock.com",
        firstName: "User",
        lastName: "User",
        permissions: ["REQUESTER"],
        role: "student",
        roleId: "ROLEID",
      ),
    );
    var responseData = jsonEncode(tokenResponse.toJson());
    var httpResponse = ResponseBody.fromString(responseData, 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    });
    when(mockAdapter.fetch(any, any, any))
        .thenAnswer((_) async => httpResponse);

    // Start app
    var mockNavigatorOb = MockNavigatorObserver();
    var mockDio = Dio();
    mockDio.httpClientAdapter = mockAdapter;
    await tester.pumpWidget(App(
      navigatorObservers: [mockNavigatorOb],
      dio: mockDio,
    ));
    await tester.pumpAndSettle();

    // Ensure that '/' and '/login' are pushed
    List pushedRoutesList =
        verify(mockNavigatorOb.didPush(captureAny, any)).captured;
    var pushedRoutes = List<PageRouteBuilder>.from(pushedRoutesList);
    expect(pushedRoutes[0].settings.name, equals("/"));
    expect(pushedRoutes[1].settings.name, equals("/login"));
    prints('1. Splash screen will automatically navigate to home page.');

    // Ensure that in the login page
    expect(find.text('Organization Url'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(RaisedButton), findsOneWidget);
    prints('2. Login screen elements are present.');

    // Enter login information
    var organizationTf = find.byWidgetPredicate(
        (w) => w is TextField && w.decoration.labelText == 'Organization Url');
    var emailTf = find.byWidgetPredicate(
        (w) => w is TextField && w.decoration.labelText == 'Email');
    var passwordTf = find.byWidgetPredicate(
        (w) => w is TextField && w.decoration.labelText == 'Password');
    await tester.enterText(organizationTf, "http://mock.com");
    await tester.enterText(emailTf, "user@mock.com");
    await tester.enterText(passwordTf, "password");
    prints('3. Entering texts to text fields is successful.');
    await tester.pumpAndSettle();

    // Find button and tap on it
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();

    // Verify request
    var reqOptionsL = verify(mockAdapter.fetch(captureAny, any, any)).captured;
    var reqOptions = List<RequestOptions>.from(reqOptionsL);
    expect(reqOptions[0].method, equals('POST'));
    expect(reqOptions[0].path, equals('http://mock.com/api/login'));
    expect(
        reqOptions[0].data, {'email': 'user@mock.com', 'password': 'password'});
    prints('4. Request(login) from app to server is valid.');

    // Ensure logged into home page
    pushedRoutesList =
        verify(mockNavigatorOb.didPush(captureAny, any)).captured;
    expect((pushedRoutesList[0] as PageRouteBuilder).settings.name,
        equals("/home"));
    prints('5. Automatically navigated to home page.');

    // Ensure data saved
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString("url"), equals("http://mock.com"));
    expect(prefs.getString("token"), equals(responseData));
    prints('6. Url and token saved in the local storage.');
  });
}
