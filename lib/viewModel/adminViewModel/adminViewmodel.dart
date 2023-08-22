import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/view/adminView/createQr.dart';

import '../../res/loginCredentials.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view/login.dart';

class AdminViewModel extends ChangeNotifier {
  String _textFieldValue = 'Direct';

  String get textFieldValue => _textFieldValue;


  

  void setTextFieldValue(String value) {
    _textFieldValue = value;
    notifyListeners();
  }
   void showOptions(BuildContext context,) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Direct'),
                onTap: () {
                  setTextFieldValue('Direct');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Distributor'),
                onTap: () {
                  setTextFieldValue('Distributor');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }




}
