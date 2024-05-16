import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrinfo/data/uploadData.dart';
import 'package:qrinfo/utils/utils.dart';
import 'package:uuid/uuid.dart';

class QrViewModel extends ChangeNotifier {
  Future<String?> getQr(list, BuildContext context) async {
    final String id = Uuid().v4();
    Uint8List? qrCode = await generateQrImageData(id);
    String? qrImageUrl = await Upload().uploadImageToFirebaseStorage(qrCode);
    Upload().uploadData(id,list, qrImageUrl, context);

    return qrImageUrl;
  }

  Future<Uint8List> generateQrImageData(String qrData) async {
    final qrPainter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      dataModuleStyle: QrDataModuleStyle(color: Colors.blue),
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Colors.blue,
      ),
    );

    final image = await qrPainter.toImage(200); // Set the desired image size
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List?> captureScreenshot(globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8list = byteData!.buffer.asUint8List();
      return uint8list;
    } catch (e) {
      // print("Error capturing screenshot: $e");
      return null;
    }
  }

  Future<void> captureAndSaveScreenshot(globalKey) async {
    Uint8List? screenshotData = await captureScreenshot(globalKey);
    if (screenshotData != null) {
      final result = await ImageGallerySaver.saveImage(screenshotData);

      if (result['isSuccess']) {
        Utils.toastMessage('Saved to Gallery');
        //  print("Screenshot saved to gallery");
      } else {
        Utils.toastMessage('Error saving to Gallery');
        // print("Error saving screenshot: ${result['errorMessage']}");
      }
    }
  }

  List infoList = [];
  addToList(val) {
    infoList.add(val);
    notifyListeners();
  }

  remove(index) {
    infoList.removeAt(index);
    notifyListeners();
  }

  deleteList() {
    infoList.clear();
    notifyListeners();
  }

  TextEditingController info = TextEditingController();
  Future<void> createInfo(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              SizedBox(width: 10),
              Text('Write Information'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: TextField(
                  controller: info,
                  decoration: InputDecoration(labelText: 'Info'),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (info.text.isNotEmpty) {
                  addToList(info.text);
                  info.clear();
                }

                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                info.clear();

                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
