import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/utils/routes/routes.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/login/loginAsUser.dart';
import 'package:qrinfo/view/adminView/createQr.dart';
import 'package:qrinfo/view/adminView/historyView.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/viewModel/adminViewModel/adminViewmodel.dart';
import 'package:qrinfo/viewModel/adminViewModel/manageUserViewModel.dart';
import 'package:qrinfo/viewModel/adminViewModel/qrViewModel.dart';
import 'package:qrinfo/viewModel/loginViewModel.dart';
import 'package:qrinfo/viewModel/signUpViewModel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter is initialized first.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminViewModel()),
        ChangeNotifierProvider(create: (_) => QrViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => ManageUserViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.blue,
            appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black))),
        initialRoute: RoutesName.loginUser,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
