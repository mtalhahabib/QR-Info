import 'package:flutter/material.dart';

import '../color.dart';

class Text_heading extends StatelessWidget {
  final String heading;
  final String text;

  Text_heading({
    Key? key,
    required this.heading,
    required this.text,
  }) : super(key: key);
  AppColors color = AppColors();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(heading,style: TextStyle(fontSize: 10),),
        SizedBox(
          width: 50,
        ),
        Text(
          text,
          style: TextStyle(
            //  fontSize: 20,
            fontWeight: FontWeight.bold,
            fontSize: 10
          ),
        ),
      ],
    );
  }
}
