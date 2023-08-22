import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qrinfo/res/components/text_heading.dart';
import 'package:qrinfo/view/adminView/qrImage.dart';

import '../../utils/utils.dart';
import 'qrHistory.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

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
                  final name = message['name'] as String;
                  final product = message['product'] as String;
                  final analyzer = message['analyzer'] as String;
                  final lot_no = message['lot_no'] as String;
                  final cat_no = message['cat_no'] as String;
                  final expiry = message['expiry'] as String;
                  final medium = message['medium'] as String;
                  final distributor_name =
                      message['distributor_name'] as String;
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
                                Text_heading(heading: "Name", text: name),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(heading: "Product", text: product),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(
                                    heading: "Analyzer", text: analyzer),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(heading: "Lot No", text: lot_no),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(heading: "Cat No", text: cat_no),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(heading: "Expiry", text: expiry),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(heading: "Medium", text: medium),
                                SizedBox(
                                  height: 5,
                                ),
                                Text_heading(
                                    heading: "Distributor Name",
                                    text: distributor_name),
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
