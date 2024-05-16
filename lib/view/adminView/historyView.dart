import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrinfo/res/components/text_heading.dart';
import 'package:qrinfo/view/adminView/qrImage.dart';

import '../../utils/utils.dart';
import 'qrHistory.dart';

class HistoryView extends StatelessWidget {
  HistoryView({required this.email, super.key});
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        title: Text(
          'History',
        ),
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('admins')
              .doc(email)
              .collection('qrData')
              .orderBy("timestamp", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Utils.toastMessage(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final messages = snapshot.data!.docs;

              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message =
                      messages[index].data() as Map<String, dynamic>;
                  final dataList = message['dataList'] as List;
                  
                  final url = message['image'] as String;
                  return Card(
                    elevation: 10,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text_heading(heading: '${index}', text: dataList),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryQr(url: url)));
                              },
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Text('No Data'),
            );
          }),
    );
  }
}
