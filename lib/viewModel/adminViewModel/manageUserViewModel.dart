import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrinfo/data/uploadData.dart';

class ManageUserViewModel extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
  Future<void> createUser(context) async {
    return 
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return
        AlertDialog(
          title: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back,color: Colors.grey,)),
              SizedBox(width: 10),
              Text('Create User'),
            ],
          ),
          content: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Upload().addUsertoDatabase(username.text, password.text,context);
                username.clear();
                password.clear();
                Navigator.of(context).pop();

              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                username.clear();
                password.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
     
          
        
      },
    );
  
  
  }
 




}
