import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/view/adminView/historyView.dart';
import 'package:qrinfo/view/adminView/manageUser/manageUsers.dart';
import 'package:qrinfo/view/adminView/scan/adminScan_qr.dart';
import 'package:qrinfo/view/userView/scanQr.dart';

import '../../utils/routes/routes_name.dart';
import '../login/loginAsUser.dart';

class startAdmin extends StatelessWidget {
  startAdmin({required this.email, Key? key}) : super(key: key);
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginUserScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome  !!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 50,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                      title: "Create Qr",
                      icon: Icons.create,
                      onPress: () {
                        Navigator.pushNamed(context, RoutesName.createQr);
                      }),
                  SizedBox(width: 10),
                  RoundButton(
                      title: "Scan Qr",
                      icon: Icons.qr_code_scanner,
                      onPress: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScanQr(email: email,)));
                      }),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                      title: "Users",
                      icon: Icons.people,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ManageUsers(email: email)));
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  RoundButton(
                      title: "Generated QRs",
                      icon: Icons.data_array,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryView(email: email,)));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
