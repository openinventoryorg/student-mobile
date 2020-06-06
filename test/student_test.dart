import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:openinventory_student_app/api/responses/itemset.dart';
import 'package:openinventory_student_app/api/responses/lab.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:openinventory_student_app/api/responses/token.dart';
import 'package:openinventory_student_app/helpers.dart';

import 'package:openinventory_student_app/main.dart';
import 'package:openinventory_student_app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends Mock implements http.Client {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockDioAdapter extends Mock implements HttpClientAdapter {}

void setMockDioResult({
  @required MockDioAdapter mockAdapter,
  @required Map<String, dynamic> response,
}) {
  when(mockAdapter.fetch(any, any, any))
      .thenAnswer((_) async => ResponseBody.fromString(
            jsonEncode(response),
            200,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType]
            },
          ));
}

/// Integration test for login flow.
///
/// Connects to a mock api instead of real api.
void main() {
  testWidgets('Student flow test', (tester) async {
    // Setup mock api
    var mockAdapter = MockDioAdapter();

    setMockDioResult(
      mockAdapter: mockAdapter,
      response: LabListResponse(labs: [
        LabResponse(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          id: "LABID",
          image: null,
          subtitle: "Another Lab",
          title: "test lab",
        )
      ]).toJson(),
    );

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
            role: "student",
            roleId: "ROLEID"),
      ).toJson())
    });

    // Start app
    var mockNavigatorOb = MockNavigatorObserver();
    var mockDio = Dio();
    mockDio.httpClientAdapter = mockAdapter;
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
    expect(pushedRoutes[1].settings.name, equals("/home"));

    // Verify request
    var reqOptionsL = verify(mockAdapter.fetch(captureAny, any, any)).captured;
    var reqOptions = List<RequestOptions>.from(reqOptionsL);
    expect(reqOptions[0].method, equals('GET'));
    expect(reqOptions[0].path, equals('http://mock.com/api/labs/list'));
    expect(reqOptions[0].data, isNull);
    await tester.pumpAndSettle();

    setMockDioResult(
      mockAdapter: mockAdapter,
      response: LabItemListResponse(labItems: [
        LabItemResponse(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          itemSetId: "ITEMSETID",
          labId: "LABID",
          serialNumber: "SN1010101",
          id: "LABITEMID",
          status: "AVAILABLE",
          itemSet: ItemsetResponse(id: "ITEMSETID", title: "Test Item"),
        )
      ]).toJson(),
    );

    // Tap on lab button and navigate to lab page
    await tester.tap(find.text(Helpers.capitalize('Test Lab')));
    await tester.pumpAndSettle();
    pushedRoutesList =
        verify(mockNavigatorOb.didPush(captureAny, any)).captured;
    pushedRoutes = List<PageRoute>.from(pushedRoutesList);
    expect(pushedRoutes[0].settings.name, equals("/home/lab/LABID"));

    // Verify request
    reqOptionsL = verify(mockAdapter.fetch(captureAny, any, any)).captured;
    reqOptions = List<RequestOptions>.from(reqOptionsL);
    expect(reqOptions[0].method, equals('GET'));
    expect(reqOptions[0].path, equals('http://mock.com/api/labs/LABID/items'));
    expect(reqOptions[0].data, isNull);
    await tester.pumpAndSettle();

    expect(find.text(Helpers.capitalize('Test Item')), findsOneWidget);
    expect(find.text(Helpers.capitalize('AVAILABLE')), findsOneWidget);
  });
}
