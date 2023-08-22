import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/view/adminView/createQr.dart';

import '../viewModel/adminViewModel/adminViewmodel.dart';
import '../viewModel/loginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController pin = TextEditingController();

  @override
  void dispose() {
    name.dispose();
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
          "Nycotech",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20
          ),
          
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
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    labelText: "Username",
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
                  wid: length,
                  onPress: () {
                    context
                        .read<LoginViewModel>()
                        .login(name.text, pin.text, context);
                    name.clear();
                    pin.clear();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
