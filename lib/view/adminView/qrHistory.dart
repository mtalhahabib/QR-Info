import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';

import '../../viewModel/adminViewModel/qrViewModel.dart';

class HistoryQr extends StatefulWidget {
  String url;
  HistoryQr({required this.url});
  @override
  State<HistoryQr> createState() => _QrImageState();
}

class _QrImageState extends State<HistoryQr> {
  GlobalKey<State> globalKey = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'History QR Code',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    children: [
                      Text(
                        'Generated QR',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(widget.url),
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
                onPress: () {
                  context
                      .read<QrViewModel>()
                      .captureAndSaveScreenshot(globalKey);
                }),
          ],
        ),
      ),
    );
  }
}
