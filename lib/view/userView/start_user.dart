import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/view/login/loginAsUser.dart';
import 'package:qrinfo/view/userView/scanQr.dart';

import '../../utils/routes/routes_name.dart';

class UserScreen extends StatelessWidget {
  UserScreen({required this.adminEmail, Key? key}) : super(key: key);
  String adminEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'User Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginUserScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    SizedBox(width: 10),
                    RoundButton(
                        title: "Scan",
                        icon: Icons.qr_code_scanner,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ScanQr(adminEmail: adminEmail)));
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
