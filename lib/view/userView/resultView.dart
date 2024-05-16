import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/userView/scanQr.dart';

import '../../utils/utils.dart';

class Result extends StatefulWidget {
  String? data;
  String adminEmail;
  Result({
    required this.data,
    required this.adminEmail,
  });
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List> getQrData() async {
    final data = await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.adminEmail)
        .collection('qrData')
        .where('id', isEqualTo: widget.data)
        .get();
    final qrData = await data.docs.map((e) {
      return [
        e['dataList'],
      ];
    }).toList();
    final companyName = await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.adminEmail)
        .get();
    final name = await companyName.data()!['companyName'];

    return [qrData, name];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.of(context).popUntil((route) {
        //   print(route.settings.name);
        //   return true;
        // });
        Navigator.pop(context);
        // Navigator.popUntil(

        //     context, (route) =>
        //     route.settings.name == RoutesName.start);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Qr Result'),
        ),
        body: FutureBuilder<List>(
            future: getQrData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Utils.toastMessage(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final message = snapshot.data![0][0] as List;
                final companyName = snapshot.data![1] as String;

                final data = message[0];
                String concatenatedItems = data.join('\n');
                
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Container(
                          height: 500,
                          width: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Data Encoded By QR',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  concatenatedItems,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
              }
              return Center(
                child: Text('Invalid Qr Code'),
              );
            }),
      ),
    );
  }
}
