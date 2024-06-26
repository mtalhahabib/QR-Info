import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrinfo/view/userView/start_user.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class Verify {
  Future<void> authenticateUser(
      String companyName, String name, String pin, context) async {
    try {
      final adminEmail = await FirebaseFirestore.instance
          .collection('admins')
          .where('companyName', isEqualTo: companyName)
          .get();

      final email = await adminEmail.docs.map((e) => e['email']).toList();
      // Reference to the Firestore collection "users"
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('admins')
          .doc(email[0])
          .collection('users');

      // Query the collection for a document where the username matches the provided name
      QuerySnapshot querySnapshot = await usersCollection
          .where('username', isEqualTo: name)
          .where('password', isEqualTo: pin)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Utils.flushBarErrorMessage('Invalid User', context);
      } else if (querySnapshot.docs.isNotEmpty) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    UserScreen(adminEmail: email[0])));
        Utils.toastMessage('User Logged in Sucessfully');
      }
    } on FirebaseException catch (e) {
      if (e.message!.contains('network') || e.message!.contains('connection')) {
        Utils.toastMessage('Check Your Internet Connection');
      }
    } catch (error) {
      Utils.toastMessage(error.toString());
    }
  }
}
