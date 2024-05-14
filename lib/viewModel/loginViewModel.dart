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

class LoginViewModel extends ChangeNotifier {
  String selectedCompany = "";

  void companySelected(name) {
    selectedCompany = name;
    notifyListeners();
  }

  goToAdminScreen(email, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => startAdmin(
                  email: email,
                )));
  }

  Future<void> loginAdmin(email, password, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pin,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => startAdmin(
                    email: email,
                  )));
      Utils.toastMessage("Admin Logged in Sucessfully");
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> login(companyName,userName, password, context) async {
    Verify().authenticateUser(companyName,userName, password, context);
  }

  void selectCompany(context) {
    // Define the list items
    final List<String> items = ['Option 1', 'Option 2', 'Option 3'];

    // Function to handle item selection
    void onItemSelected(int index) {
      companySelected(items[index]);
      Navigator.pop(context); // Close the dialog
      // Handle selection based on index (optional)
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an Option'),
          content: SizedBox(
            height: 300, // Adjust height as needed
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () => onItemSelected(index),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
