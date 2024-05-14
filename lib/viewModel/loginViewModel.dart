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

class LoginViewModel extends ChangeNotifier {
  String selectedCompany = "";

  bool isloading = false;
  changeLoading(value) {
    isloading = value;
    notifyListeners();
  }

  void companySelected(name) {
    selectedCompany = name;
    notifyListeners();
  }

  goToAdminScreen(email, context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => startAdmin(
                  email: email,
                )));
  }

  Future<void> loginAdmin(email, password, context) async {
    try {
      changeLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => startAdmin(
                    email: email,
                  )));
      changeLoading(false);
      Utils.toastMessage("Admin Logged in Sucessfully");
    } catch (e) {
      changeLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> login(companyName, userName, password, context) async {
    changeLoading(true);
    await Verify().authenticateUser(companyName, userName, password, context);
    changeLoading(false);
  }

  Future getCompanyNames() async {
    try{
      final companyNames =
        await FirebaseFirestore.instance.collection('admins').get();
    final namesList =
        await companyNames.docs.map((e) => e['companyName']).toList();
    
    return namesList;
    }
    catch(e){
      Utils.toastMessage(e.toString());
    }
  }

  void selectCompany(context) {
    // Define the list items
    // final List<String> items = ['Option 1', 'Option 2', 'Option 3'];

    // Function to handle item selection
    // void onItemSelected(int index) {
    //   companySelected(items[index]);
    //   Navigator.pop(context); // Close the dialog
    //   // Handle selection based on index (optional)
    // }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an Option'),
          content: SizedBox(
            height: 300, // Adjust height as needed
            child: FutureBuilder(
                future: getCompanyNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final items = snapshot.data;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(items[index]),
                          onTap: () {
                            Navigator.pop(context);
                            companySelected(items[index]);
                            // Close the dialog
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No Company Found'),
                    );
                  }
                }),
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
