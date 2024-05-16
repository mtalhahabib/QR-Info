import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/utils.dart';
import 'package:qrinfo/view/adminView/historyView.dart';
import 'package:qrinfo/view/adminView/qrImage.dart';
import 'package:qrinfo/viewModel/adminViewModel/adminViewmodel.dart';
import 'package:qrinfo/viewModel/adminViewModel/qrViewModel.dart';

class CreateQr extends StatefulWidget {
  CreateQr({required this.email, super.key});
  String email;
  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Generate QR Code",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(child:
            Consumer<AdminViewModel>(builder: (context, textFieldModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Create',
                  icon: Icons.create,
                  onPress: () {
                    context.read<QrViewModel>().createInfo(context);
                  }),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<QrViewModel>(builder: (context, qr, child) {
                      return ListView.builder(
                        itemCount: qr.infoList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 7,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Text(
                                  index.toString(),
                                ),
                                title: Column(
                                  children: [
                                    Text(
                                      qr.infoList[index],
                                      maxLines: null,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      qr.remove(index);
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                            ),
                          );
                        },
                      );
                    })),
              ),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                  title: "Generate",
                  wid: length,
                  icon: Icons.qr_code,
                  onPress: () async {
                    final getInfoList = context.read<QrViewModel>().infoList;
                    Future<String?> url =
                         context.read<QrViewModel>().getQr(getInfoList, context);
                    Future.delayed(Duration(seconds: 3), () {});
                  await  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QrImage(
                                  url: url,
                                )));
                    context.read<QrViewModel>().deleteList();
                  })
            ],
          );
        })),
      ),
    );
  }
}
