import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/utils/utils.dart';
import 'package:qrinfo/view/adminView/createQr.dart';
import 'package:qrinfo/viewModel/signUpViewModel.dart';

import '../viewModel/adminViewModel/adminViewmodel.dart';
import '../viewModel/loginViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController confirmpin = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    pin.dispose();
    confirmpin.dispose();
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
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
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
                  hintText: "Company Name",
                  labelText: "Company Name",
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
              height: 25,
            ),
            Container(
              width: length,
              height: 50,
              child: TextField(
                controller: confirmpin,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(child:
                Consumer<SignUpViewModel>(builder: (context, company, child) {
              return company.isloading? CircularProgressIndicator()  : RoundButton(
                  title: "Sign Up",
                  icon: Icons.start,
                  wid: length,
                  onPress: () {
                    if (pin.text.isEmpty ||
                        confirmpin.text.isEmpty ||
                        name.text.isEmpty ||
                        email.text.isEmpty) {
                      Utils.toastMessage("Please Fill All the Fields");
                    } else {
                      if (pin.text != confirmpin.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Password does not match'),
                        ));
                        return;
                      } else {
                        context.read<SignUpViewModel>().signUp(name.text,
                            email.text, pin.text, confirmpin.text, context);
                        name.clear();
                        pin.clear();
                        confirmpin.clear();
                        email.clear();
                      }
                    }
                  });
            })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.loginAdmin);
                    },
                    child: Text('Go to Login Screen'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
