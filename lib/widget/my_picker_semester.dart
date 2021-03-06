import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../adapter/semester_adapter.dart';
import '../adapter/subject_adapter.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import 'my_text.dart';


class MyPicker extends StatefulWidget {

  late String semesterValue;
  final bool all;
  final bool signedUp;
  MyPicker(this.semesterValue, {Key? key, required this.signedUp, required this.all}) : super(key: key);

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

  @override
  initState()  {
    super.initState();
    subjectAdapter = context.read<SubjectAdapter>();
    semesterAdapter = context.read<SemesterAdapter>();
    semesterAdapter.getSemesters();
    userAdapter.getCurrentUser(context);
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
                        child: Text( tr("choose_semester"),
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
                      if( widget.all == true )Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CupertinoButton(
                          child: Text( tr("all"),
                            style: TextStyle(
                                color: MyColors.background1, fontWeight: FontWeight.w600),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              widget.semesterValue = "All";
                              if(userAdapter.currentUser.role == true){
                               subjectAdapter.getSubjectsById(userAdapter.currentUser.uid!);
                              } else{
                                if(widget.signedUp == true){
                                  subjectAdapter.getSubjectsBySignedUp(userAdapter.currentUser);
                                } else{
                                  subjectAdapter.getSubjectsByUniversity(userAdapter.currentUser);
                                }
                              }
                            });

                          },
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
               MyText( text: widget.semesterValue),
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
                setState(() {
                  widget.semesterValue = text.data.toString();
                  userAdapter.currentUser.currentSemester = widget.semesterValue;
                  userAdapter.changeCurrentSemester(userAdapter.currentUser,context);
                  if(userAdapter.currentUser.role == true){
                    subjectAdapter.getSubjectsByIdBySemester(userAdapter.currentUser);
                  } else {
                    if( widget.signedUp == true){
                      subjectAdapter.getSubjectsBySignedUpBySemester(userAdapter.currentUser, userAdapter.currentUser.currentSemester!);
                    }
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