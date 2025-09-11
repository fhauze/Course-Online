import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  Future<void> _handleBarcode(String code, BuildContext context) async {
    final url = Uri.parse("http://127.0.0.1:8000/api/scan/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"qr_data": code, "user_id": "123"}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["type"] == "product") {
        Navigator.pushNamed(context, "/product/${data["id"]}");
      } else if (data["type"] == "reward") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("🎉 Kamu dapat ${data["points"]} poin!")),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("QR tidak valid")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("Scan QR"),
        backgroundColor: Colors.blueAccent,
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          if (barcode.rawValue != null) {
            _handleBarcode(barcode.rawValue!, context);
          }
        },
      ),
    );
  }
}
