import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/viewModel/adminViewModel/manageUserViewModel.dart';

import '../../../data/uploadData.dart';
import '../../../utils/utils.dart';

class ManageUsers extends StatefulWidget {
  ManageUsers({required String this.email, super.key});
  String email;
  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Manage Users"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              RoundButton(
                  title: 'Create',
                  icon: Icons.create,
                  onPress: () {
                    context.read<ManageUserViewModel>().createUser(context);
                  }),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('admins')
                            .doc(widget.email)
                            .collection('users')
                            .orderBy("timestamp", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Utils.toastMessage(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text('No User Found'),
                            );
                          }
                          if (snapshot.hasData) {
                            final messages = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index].data()
                                    as Map<String, dynamic>;
                                final userName = message['username'] as String;
                                final password = message['password'] as String;
                                return Card(
                                  elevation: 7,
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Text(
                                        index.toString(),
                                      ),
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'UserName:   ',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Text(
                                                userName,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                'Password:    ',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Text(
                                                password,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            Upload().deleteUser(
                                              messages[index].id,
                                            );
                                          },
                                          icon: Icon(Icons.delete)),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: Text('No Data Found'),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
