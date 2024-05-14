import 'package:flutter/material.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/manageUser/manageUsers.dart';
import 'package:qrinfo/view/adminView/scan/adminResultView.dart';
import 'package:qrinfo/view/login/loginAsAdmin.dart';
import 'package:qrinfo/view/login/loginAsUser.dart';
import 'package:qrinfo/view/adminView/createQr.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/signUp.dart';
import 'package:qrinfo/view/userView/resultView.dart';
import 'package:qrinfo/view/userView/scanQr.dart';
import 'package:qrinfo/view/userView/start_user.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.createQr:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateQr());

      case RoutesName.loginUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginUserScreen());
      case RoutesName.loginAdmin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginAdminScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
