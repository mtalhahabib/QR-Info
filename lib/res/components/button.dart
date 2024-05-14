import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final double wid;
  final IconData icon;
  final VoidCallback onPress;

  RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    this.wid = 120,
    required this.icon,
    required this.onPress,
  }) : super(key: key);
  AppColors color = AppColors();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 45,
        width: wid,
        decoration: BoxDecoration(
            color: color.buttonColor, borderRadius: BorderRadius.circular(3)),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: color.whiteColor,
                      ),
                      Text(
                        title,
                        style: TextStyle(color: color.whiteColor),
                      ),
                    ],
                  )),
      ),
    );
  }
}
