import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/utils.dart';

import '../../viewModel/adminViewModel/qrViewModel.dart';

class QrImage extends StatefulWidget {
  Future<String?> url;
  QrImage({required this.url});
  @override
  State<QrImage> createState() => _QrImageState();
}

class _QrImageState extends State<QrImage> {
  GlobalKey<State> globalKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'QR Code',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String?>(
              future: widget.url,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while waiting for the URL.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      RepaintBoundary(
                        key: globalKey,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Nycotech',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Image.network(snapshot.data!),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      RoundButton(
                          title: "Take ScreenShot",
                          icon: Icons.screenshot,
                          wid: length,
                          onPress: () {context.read<QrViewModel>().
                            captureAndSaveScreenshot(globalKey);
                       }),
                    ],
                  ); // Use the retrieved URL.
                } else {
                  return Text('No data available.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
