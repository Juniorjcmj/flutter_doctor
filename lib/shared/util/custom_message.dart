import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum MessageType {
  success,
  error,
  info,
}

class MessageCustom {

  static void showToast(String message, MessageType type, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case MessageType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon = Icons.check_circle;
        break;
      case MessageType.error:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        icon = Icons.cancel;
        break;
      case MessageType.info:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        icon = Icons.info;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }


  static void showSnack(BuildContext context, String message, MessageType type) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case MessageType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        icon =Icons.check_circle;
        break;
      case MessageType.error:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        icon = Icons.close;
        break;
      case MessageType.info:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        icon = Icons.info_outline;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: false,
        clipBehavior: Clip.antiAlias,
        closeIconColor: textColor,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(milliseconds: 1000),
        backgroundColor: backgroundColor,
        content:
         Container(
          child:Row(children: [
            Icon(icon, color: textColor,),
            const SizedBox(width: 10,),
            Expanded(child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),),
          ],),
        ),

      ),
    );
  }
}
