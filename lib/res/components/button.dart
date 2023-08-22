import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final double wid;
  final VoidCallback onPress;

  RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    this.wid = 70,
    required this.onPress,
  }) : super(key: key);
  AppColors color=AppColors();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 30,
        width: wid,
        decoration: BoxDecoration(
            color: color.buttonColor, borderRadius: BorderRadius.circular(3)),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: TextStyle(color: color.whiteColor),
                  )),
      ),
    );
  }
}
