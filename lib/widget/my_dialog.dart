import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/colors.dart';

Future showErrorMessage (BuildContext context, String text) {

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.dialogcolor,
          title: Text(text,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  borderRadius: const BorderRadius.all(const Radius.circular(20)),
                ),
              ],
            ),
          ],
        );
      });
}
