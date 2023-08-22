import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/userView/scanQr.dart';

import '../../utils/utils.dart';

class Result extends StatefulWidget {
  String? data;
  Result({
    required this.data,
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('qrData')
                .where('id', isEqualTo: widget.data)
                .snapshots(),
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
                final messages = snapshot.data!.docs;

                final message = messages[0].data() as Map<String, dynamic>;
                final name = message['name'] as String;
                final product = message['product'] as String;
                final analyzer = message['analyzer'] as String;
                final lot_no = message['lot_no'] as String;
                final cat_no = message['cat_no'] as String;
                final expiry = message['expiry'] as String;
                final medium = message['medium'] as String;
                final distributor_name = message['distributor_name'] as String;

                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                              'Nycotech',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Hospital Name:           $name'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Analyzer Model:              $analyzer'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('LOT No:                      $lot_no'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('CAT No:                      $cat_no'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Expiry:                      $expiry'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Medium:                   $medium'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Distributor:                 $distributor_name'),
                          ],
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
