import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';
import 'package:task_list_alif/models/page_enum.dart';
import 'package:flutter/material.dart';
import 'package:task_list_alif/models/task.dart';
import 'package:task_list_alif/screens/edit_task_screen/edit_task_screen.dart';
import 'package:task_list_alif/widgets/w_task_item.dart';

import 'bloc/data_screen_bloc.dart';

class DataScreen extends StatefulWidget {
  final List<Task> taskList;
  final DataScreenBloc dataScreenBloc;

  DataScreen({Key? key, required this.taskList, required this.dataScreenBloc})
      : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12),
      child: Column(
        mainAxisAlignment: widget.taskList.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (widget.taskList.isEmpty) ...{
            SvgPicture.asset(
              MyIcons.box,
              width: 150,
              height: 150,
              color: MyColors.C_2A2E3D.withOpacity(0.9),
            ),
          } else ...{
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Slidable(
                    actionPane: const SlidableScrollActionPane(),
                    actions: [
                      IconSlideAction(
                        closeOnTap: true,
                        iconWidget: SvgPicture.asset(
                          widget.taskList[index].status != "done"
                              ? MyIcons.tick
                              : MyIcons.waiting,
                          color: MyColors.white,
                          width: 24,
                          height: 24,
                        ),
                        caption: widget.taskList[index].status != "done"
                            ? "Mark as Done"
                            : "Mark as In Progress",
                        color: widget.taskList[index].status != "done"
                            ? MyColors.green
                            : MyColors.orange,
                        foregroundColor: Colors.white,
                        onTap: () {
                          if (widget.taskList[index].status != "done") {
                            widget.dataScreenBloc.add(UpdateStatus(
                                status: "done",
                                id: widget.taskList[index].id!));
                          } else {
                            widget.dataScreenBloc.add(UpdateStatus(
                                status: "in_progress",
                                id: widget.taskList[index].id!));
                          }
                        },
                      ),
                    ],
                    child: WTaskItem(
                      task: widget.taskList[index],
                      onTapEdit: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => EditTaskScreen(
                              dataScreenBloc: widget.dataScreenBloc,
                              task: widget.taskList[index],
                            ),
                          ),
                        );
                      },
                      onTapDelete: () => showDeleteDialog(index),
                    ),
                  ),
                ),
                itemCount: widget.taskList.length,
              ),
            ),
          }
        ],
      ),
    );
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext alertContext) => AlertDialog(
        backgroundColor: MyColors.C_2A2E3D,
        title: Text(
          "Delete Task",
          style: MyTextStyle.ubuntuMedium.copyWith(color: MyColors.red),
        ),
        content: Text(
          "Do you want to delete this task?",
          style: MyTextStyle.ubuntuRegular.copyWith(color: MyColors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //Navigator.of(alertContext).pop();
            },
            behavior: HitTestBehavior.opaque,
            child: Text("No",
                style:
                    MyTextStyle.ubuntuMedium.copyWith(color: MyColors.white)),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              widget.dataScreenBloc.add(
                DeleteTaskEvent(id: widget.taskList[index].id!),
              );
              Navigator.of(alertContext).pop();
            },
            behavior: HitTestBehavior.opaque,
            child: Text("Yes",
                style: MyTextStyle.ubuntuMedium.copyWith(color: MyColors.red)),
          ),
        ],
      ),
    );
  }
}
