import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

abstract class Helpers {
  static String capitalize(String s) {
    if (s.length == 0) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  static Future<String> scanQR() async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('The user did not grant the camera permission!');
      } else {
        print('Unknown error: $e');
      }
    } on FormatException {
      // User pressed back
    } catch (e) {
      print('Unknown error: $e');
    }
    return barcode;
  }
}
