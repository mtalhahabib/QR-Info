import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/routes/routes_name.dart';
import 'package:qrinfo/view/adminView/createQr.dart';

import '../../viewModel/adminViewModel/adminViewmodel.dart';
import '../../viewModel/loginViewModel.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key}) : super(key: key);

  @override
  State<LoginUserScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<LoginUserScreen> {
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
          "Login As User",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                  )),
              SizedBox(
                height: 40,
              ),
              Consumer<LoginViewModel>(builder: (context, company, child) {
                return Container(
                  width: length,
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      context.read<LoginViewModel>().selectCompany(context);
                    },

                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      hintText: company.selectedCompany == ""
                          ? "Select Company"
                          : company.selectedCompany,
                      labelText: "Select Company",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 25,
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
                height: 70,
              ),
              RoundButton(
                  title: "Submit",
                  icon: Icons.login,
                  wid: length,
                  onPress: () {
                    final companyName=context.read<LoginViewModel>().selectedCompany;
                    context
                        .read<LoginViewModel>()
                        .login(companyName,name.text, pin.text, context);
                    name.clear();
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
                        Navigator.pushReplacementNamed(
                            context, RoutesName.loginAdmin);
                      },
                      child: Text('Login As Admin'))
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
                        Navigator.pushReplacementNamed(
                            context, RoutesName.signUp);
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
