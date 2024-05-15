import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/utils/utils.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/userView/scanQr.dart';

class AdminScanResult extends StatefulWidget {
  String? data;
  String email;
  AdminScanResult({
    required this.data,
    required this.email,
  });
  @override
  State<AdminScanResult> createState() => _ResultState();
}

class _ResultState extends State<AdminScanResult> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List> getQrData() async {
    final data = await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.email)
        .collection('qrData')
        .where('id', isEqualTo: widget.data)
        .get();
    final qrData = await data.docs.map((e) {
      return [
        e['name'],
        e['product'],
        e['analyzer'],
        e['lot_no'],
        e['cat_no'],
        e['expiry'],
        e['medium'],
        e['distributor_name']
      ];
    }).toList();
    final companyName = await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.email)
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
                final name = message[0] as String;
                final product = message[1] as String;
                final analyzer = message[2] as String;
                final lot_no = message[3] as String;
                final cat_no = message[4] as String;
                final expiry = message[5] as String;
                final medium = message[6] as String;
                final distributor_name = message[7] as String;

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
