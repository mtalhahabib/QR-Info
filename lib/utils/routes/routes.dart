import 'package:flutter/material.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/manageUser/manageUsers.dart';
import 'package:qrinfo/view/login.dart';
import 'package:qrinfo/view/adminView/createQr.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/userView/resultView.dart';
import 'package:qrinfo/view/userView/scanQr.dart';
import 'package:qrinfo/view/userView/start_user.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.startAdmin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const startAdmin());
      case RoutesName.startUser:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UserScreen());

      case RoutesName.createQr:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateQr());

      case RoutesName.manageUsers:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ManageUsers());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
     case RoutesName.scanQr:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ScanQr());
     case RoutesName.result:
     final data = settings.arguments as String?;
        return MaterialPageRoute(
            builder: (BuildContext context) =>  Result(data: data,));
     
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
