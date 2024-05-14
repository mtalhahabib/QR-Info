import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/data/verifyUser.dart';
import 'package:qrinfo/view/adminView/createQr.dart';
import 'package:qrinfo/view/adminView/start_admin.dart';

import '../../res/loginCredentials.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../view/login/loginAsUser.dart';

class SignUpViewModel extends ChangeNotifier {
  bool isloading = false;
  changeLoading(value) {
    isloading = value;
    notifyListeners();
  }

  Future<void> signUp(
      name, email, password, confirmPassword, BuildContext context) async {
    try {
      changeLoading(true);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection("admins").doc(email).set({
        "email": email,
        'companyName': name,
        'password': password,
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => startAdmin(
                    email: email,
                  )));

      Utils.toastMessage("You are Registered as Admin");
      changeLoading(false);
    } on FirebaseAuthException catch (e) {
      changeLoading(false);
      if (e.code == 'weak-password') {
        Utils.toastMessage('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        Utils.toastMessage('Email already in Use');
      }
    } catch (e) {
      changeLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
