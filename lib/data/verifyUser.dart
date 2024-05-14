import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class Verify {
  Future<void> authenticateUser(
      String companyName, String name, String pin, context) async {
    try {
      final adminEmail = await FirebaseFirestore.instance
          .collection('admins')
          .where('conmpanyName', isEqualTo: companyName)
          .get();
      final email = adminEmail.docs[0]['email'];
      // Reference to the Firestore collection "users"
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('admins')
          .doc(email)
          .collection('users');

      // Query the collection for a document where the username matches the provided name
      QuerySnapshot querySnapshot = await usersCollection
          .where('username', isEqualTo: name)
          .where('password', isEqualTo: pin)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Utils.flushBarErrorMessage('Invalid User', context);
      } else if (querySnapshot.docs.isNotEmpty) {
        Navigator.pushNamed(context, RoutesName.startUser);
        Utils.toastMessage('User Logged in Sucessfully');
      }
    } catch (error) {
      Utils.toastMessage(error.toString());
    }
  }
}
