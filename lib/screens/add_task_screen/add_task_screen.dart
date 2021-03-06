import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';
import 'package:task_list_alif/screens/data_screen/bloc/data_screen_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  final DataScreenBloc dataScreenBloc;
  const AddTaskScreen({Key? key, required this.dataScreenBloc})
      : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late DateTime pickedDate;
  late TextEditingController textEditingController;
  @override
  void initState() {
    pickedDate = DateTime.now();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.dataScreenBloc,
      child: BlocBuilder<DataScreenBloc, DataScreenState>(
        builder: (context, state) {
          if (state is TaskAdded) {
            widget.dataScreenBloc.add(LoadTasks());
            Navigator.of(context).pop();
          }

          return Scaffold(
            backgroundColor: MyColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: MyColors.backgroundColor,
              elevation: 0,
              title: Text(
                "Add New Task",
                style: MyTextStyle.ubuntuBold.copyWith(fontSize: 20),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: MyTextStyle.ubuntuMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      style: MyTextStyle.ubuntuRegular
                          .copyWith(color: MyColors.white),
                      decoration: InputDecoration(
                          errorText: errorText,
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.C_2A2E3D),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: MyColors.primaryColor),
                          ),
                          hintText: "Task Name",
                          contentPadding: EdgeInsets.only(left: 10),
                          hintStyle: MyTextStyle.ubuntuRegular
                              .copyWith(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Date",
                    style: MyTextStyle.ubuntuMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: pickDate,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          width: 1,
                          color: MyColors.C_2A2E3D,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}",
                              style: MyTextStyle.ubuntuRegular,
                            ),
                          ),
                          SvgPicture.asset(
                            MyIcons.calendar,
                            width: 14,
                            height: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      addTask(textEditingController.text, pickedDate);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: state is TaskAdding
                          ? CupertinoActivityIndicator()
                          : Text(
                              "Add task",
                              style: MyTextStyle.ubuntuRegular,
                            ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool canAdd = true;
  String? errorText = null;

  addTask(String title, DateTime dateTime) {
    if (title.isEmpty || title.length == 0) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          canAdd = false;
          errorText = "Please, write the task";
        });
      });
    } else {
      canAdd = true;
    }

    if (canAdd) {
      widget.dataScreenBloc.add(AddTaskEvent(title: title, dateTime: dateTime));
    }
  }

  void pickDate() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));

    if (dateTime != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          pickedDate = dateTime;
        });
      });
    }
  }
}
