import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'my_text.dart';

class SelectedDate extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void changeDate(DateTime value) {
    selectedDate = value;
  }

  void setToday() {
    selectedDate = DateTime.now();
  }
}

final DateFormat formatter = DateFormat('yyyy-MM-dd');

class MyDate extends StatefulWidget {
  MyDate({Key? key, required this.selectedDate}) : super(key: key);

  late SelectedDate selectedDate;
  @override
  _MyDateState createState() {
    return _MyDateState();
  }
}

class _MyDateState extends State<MyDate> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CupertinoButton(
            child: Text(tr("choose_date"),
                style:  TextStyle(
                    color: MyColors.background1, fontWeight: FontWeight.w600)),
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () {
              showDatePicker();
            },
          ),
        ),
        MyText(text: formatter.format(widget.selectedDate.selectedDate)),
      ],
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value.toString() != widget.selectedDate.selectedDate.toString()) {
                  setState(() {
                    widget.selectedDate.changeDate(value);
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: DateTime.now().year + 1,
            ),
          );
        });
  }
}
