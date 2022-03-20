import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../adapter/semester_adapter.dart';
import '../adapter/subject_adapter.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import 'my_text.dart';

class SelectedValue extends ChangeNotifier {
  String selectedValue = "";


  changeValue(String value) {
    selectedValue = value;
  }

  String getValue() {
    return selectedValue;
  }
}

class MyPicker extends StatefulWidget {
  const MyPicker({Key? key}) : super(key: key);


  @override
  _MyPickerState createState()
  {
    return _MyPickerState();
  }

}

class _MyPickerState extends State<MyPicker> {

  SemesterAdapter semesterAdapter = SemesterAdapter();
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();
  var semester = SelectedValue();

  @override
  initState()  {
    super.initState();
    subjectAdapter = context.read<SubjectAdapter>();
    semesterAdapter = context.read<SemesterAdapter>();
    semesterAdapter.getSemesters();
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
               MyText( text: semester.selectedValue),
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
              children: semesterAdapter.semesters.map((e) => Text(e.semester!)).toList(),
              onSelectedItemChanged: (value){
                Text text = semesterAdapter.semesters.map((e) => Text(e.semester!)).toList()[value];
                semester.selectedValue = text.data.toString();
                setState(() {
                  semester.changeValue( text.data.toString());
                  print(semester.selectedValue);
                  userAdapter.currentUser.currentSemester = semester.selectedValue;
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