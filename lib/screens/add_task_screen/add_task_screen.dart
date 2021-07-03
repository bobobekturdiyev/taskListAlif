import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late DateTime pickedDate;

  @override
  void initState() {
    pickedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                style:
                    MyTextStyle.ubuntuRegular.copyWith(color: MyColors.white),
                decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.C_2A2E3D),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.primaryColor),
                    ),
                    hintText: "Task Name",
                    contentPadding: EdgeInsets.only(left: 10),
                    hintStyle:
                        MyTextStyle.ubuntuRegular.copyWith(color: Colors.grey)),
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
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                "Add task",
                style: MyTextStyle.ubuntuRegular,
              ),
            )
          ],
        ),
      ),
    );
  }

  void pickDate() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));

    if (dateTime != null) {
      setState(() {
        pickedDate = dateTime;
      });
    }
  }
}
