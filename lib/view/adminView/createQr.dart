import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrinfo/res/components/button.dart';
import 'package:qrinfo/utils/utils.dart';
import 'package:qrinfo/view/adminView/historyView.dart';
import 'package:qrinfo/view/adminView/qrImage.dart';
import 'package:qrinfo/viewModel/adminViewModel/adminViewmodel.dart';
import 'package:qrinfo/viewModel/adminViewModel/qrViewModel.dart';

class CreateQr extends StatefulWidget {
  const CreateQr({super.key});

  @override
  State<CreateQr> createState() => _CreateQrState();
}

class _CreateQrState extends State<CreateQr> {
  TextEditingController lab_name = TextEditingController();
  TextEditingController product_name = TextEditingController();
  TextEditingController analyzer_model = TextEditingController();
  TextEditingController lot_no = TextEditingController();
  TextEditingController cat_no = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController distributor = TextEditingController();

  @override
  void dispose() {
    lab_name.dispose();
    product_name.dispose();
    analyzer_model.dispose();
    lot_no.dispose();
    cat_no.dispose();
    expiry.dispose();
    distributor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Generate QR Code",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        
      ),
      body: SingleChildScrollView(
        child: Center(child:
            Consumer<AdminViewModel>(builder: (context, textFieldModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Nycotech',style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,),),
              SizedBox(
                height: 20,),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: lab_name,
                  decoration: InputDecoration(
                    hintText: "Enter name",
                    labelText: "Lab/Hospital Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: product_name,
                  decoration: InputDecoration(
                    hintText: "product",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: analyzer_model,
                  decoration: InputDecoration(
                    hintText: "analyzer_model",
                    labelText: "Analyzer Model",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: lot_no,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "lot_no",
                    labelText: "LOT no",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: cat_no,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "cat_no",
                    labelText: "CAT No",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: expiry,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: "expiry_date",
                    labelText: "Expiry",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                width: length,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down_circle_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onTap: () {
                    context.read<AdminViewModel>().showOptions(
                          context,
                        );
                  },
                  controller: TextEditingController(
                    text: textFieldModel.textFieldValue,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: length,
                height: 40,
                child: TextField(
                  controller: distributor,
                  decoration: InputDecoration(
                    hintText: "distributor",
                    labelText: "Distributor Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                  title: "Generate",
                  wid: length,
                  icon: Icons.qr_code,
                  onPress: () {
                    if (lab_name.text.isNotEmpty &&
                        product_name.text.isNotEmpty &&
                        analyzer_model.text.isNotEmpty &&
                        lot_no.text.isNotEmpty &&
                        cat_no.text.isNotEmpty &&
                        expiry.text.isNotEmpty &&
                        distributor.text.isNotEmpty
                        ) {
                      Future<String?> url = context.read<QrViewModel>().getQr(
                          lab_name.text,
                          product_name.text,
                          analyzer_model.text,
                          lot_no.text,
                          cat_no.text,
                          expiry.text,
                          textFieldModel.textFieldValue,
                          distributor.text,
                          context);
                      Future.delayed(Duration(seconds: 3), () {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrImage(
                                    url: url,
                                  )));
                      lab_name.clear();
                      product_name.clear();
                      analyzer_model.clear();
                      expiry.clear();
                      cat_no.clear();
                      lot_no.clear();
                      distributor.clear();

                    } else {
                      Utils.flushBarErrorMessage(
                          "Please fill all the fields", context);
                    }
                  })
            ],
          );
        })),
      ),
    );
  }
}
