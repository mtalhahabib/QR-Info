import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/createQr.dart';

import '../../viewModel/adminViewModel/adminViewmodel.dart';
import '../../viewModel/loginViewModel.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({Key? key}) : super(key: key);

  @override
  State<LoginAdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<LoginAdminScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController pin = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login As Admin",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                width: length,
                height: 50,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: length,
                height: 50,
                child: TextField(
                  controller: pin,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              RoundButton(
                  title: "Submit",
                  icon: Icons.login_outlined,
                  wid: length,
                  onPress: () {
                    context
                        .read<LoginViewModel>()
                        .loginAdmin(email.text, pin.text, context);
                    email.clear();
                    pin.clear();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RoutesName.loginUser);
                      },
                      child: Text('Login As User'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, RoutesName.signUp);
                      },
                      child: Text('Go to SignUp Page'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
