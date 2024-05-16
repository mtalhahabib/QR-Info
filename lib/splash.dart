// splash screen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';
import 'package:qrinfo/view/login/loginAsUser.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getHomePage() async {
    if (await FirebaseAuth.instance.currentUser != null) {
      return startAdmin(email: await FirebaseAuth.instance.currentUser!.email!);
    } else {
      return LoginUserScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Delay the navigation to the next screen by 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return FutureBuilder(
            future: getHomePage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            });
      }));
    });

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('assets/logo.png')));
  }
}
