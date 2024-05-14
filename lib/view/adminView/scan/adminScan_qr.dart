import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrinfo/view/adminView/scan/adminResultView.dart';
import 'package:qrinfo/view/userView/resultView.dart';

import '../../../utils/routes/routes_name.dart';

class AdminScanQr extends StatefulWidget {
  AdminScanQr({required this.email, super.key});
  String email;
  @override
  State<AdminScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<AdminScanQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool shouldStopScanning = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderRadius: 16,
                borderColor: Colors.blue,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? CircularProgressIndicator()
                  : Text('Hold the camera on the QR code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Cancel the listener
      // Cancel the subscription
      if (!shouldStopScanning) {
        setState(() {
          result = scanData;
        });
        controller.dispose();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AdminScanResult(
                      data: result!.code,
                      email: widget.email,
                    )));
      }
    });
  }
}
