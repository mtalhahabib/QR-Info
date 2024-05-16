import 'package:flutter/material.dart';

import '../color.dart';

class Text_heading extends StatelessWidget {
  final String heading;
  final List text;

  Text_heading({
    Key? key,
    required this.heading,
    required this.text,
  }) : super(key: key);
  AppColors color = AppColors();
  @override
  Widget build(BuildContext context) {
    String concatenatedItems = text.join('\n');
    return Row(
      children: [
        Text(
          heading,
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(
          width: 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.5,
          child: Text(
            concatenatedItems,
            maxLines: null,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
