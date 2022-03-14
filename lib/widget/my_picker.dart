
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../adapter/subject_adapter.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import 'my_text.dart';

class MyPicker extends StatefulWidget {
  const MyPicker({Key? key}) : super(key: key);

  @override
  _MyPickerState createState()
  {
    return _MyPickerState();
  }
}

class _MyPickerState extends State<MyPicker> {
  List <Text> semesters = [
    Text("2020/2021/1"),
    Text("2020/2021/2"),
    Text("2021/2022/1"),
    Text("2021/2022/2"),
  ];
  String selectedValue = "";
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();

  @override
  initState()  {
    super.initState();
    subjectAdapter = context.read<SubjectAdapter>();
    userAdapter.getUserById(context);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        child: Text( "Choose semester",
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
                    ],
                  ),

                ),
               MyText( text: selectedValue),
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
              children: semesters,
              onSelectedItemChanged: (value){
                Text text = semesters[value];
                selectedValue = text.data.toString();
                setState(() {
                  userAdapter.currentUser.currentSemester = selectedValue;
                  userAdapter.changeCurrentSemester(userAdapter.currentUser,context);
                  if(userAdapter.currentUser.role == true){
                    subjectAdapter.getSubjectsByIdBySemester(userAdapter.currentUser);
                  } else {
                    subjectAdapter.getSubjectsBySemester(userAdapter.currentUser);
                  }

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