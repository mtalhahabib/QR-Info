import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/data/verifyUser.dart';
import 'package:qrinfo/view/adminView/createQr.dart';

import '../../res/loginCredentials.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view/login.dart';

class LoginViewModel extends ChangeNotifier {
  void login(name, password, BuildContext context) {
    
      if (name == admin && password == pin) {
      Navigator.pushNamed(context, RoutesName.startAdmin);
      Utils.toastMessage("Admin Logged in Sucessfully");
    } 
   
    else {
Verify().authenticateUser(name, password, context);
      
    }
  }



}
