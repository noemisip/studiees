import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../adapter/subject_adapter.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import 'my_text.dart';

class MyTypePicker extends StatefulWidget {
  MyTypePicker(this.typeValue,{Key? key}) : super(key: key);

  late String typeValue;
  @override
  _MyPickerState createState()
  {
    return _MyPickerState();
  }
}

class _MyPickerState extends State<MyTypePicker> {
  List <Text> types = [
    Text("ZH"),
    Text("Vizsga"),
    Text("Házi feladat"),
  ];
 // String selectedValue = "";

  @override
  initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                    child: Text(tr("choose_type"),
                      style: TextStyle(
                          color: MyColors.background1, fontWeight: FontWeight.w600),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      showPicker();
                    },
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  MyText( text: widget.typeValue),
                ],
              ),

            ),

          ]
      );
  }

  void showPicker()
  {  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoPicker(
              children: types,
              onSelectedItemChanged: (value){
                Text text = types[value];
                widget.typeValue = text.data.toString();
                setState(() {
                });
              },
              itemExtent: 25,
              diameterRatio:1,
              useMagnifier: true,
              magnification: 1.3,
              looping: true,
            )
        );
      }
  );
  }
}