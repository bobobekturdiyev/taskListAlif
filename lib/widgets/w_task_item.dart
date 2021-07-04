import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';
import 'package:task_list_alif/models/task.dart';
import 'package:intl/intl.dart';

class WTaskItem extends StatefulWidget {
  final Task task;
  final GestureTapCallback onTapDelete, onTapEdit;
  const WTaskItem({
    Key? key,
    required this.task,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  State<WTaskItem> createState() => _WTaskItemState();
}

class _WTaskItemState extends State<WTaskItem> {
  late String date;
  late DateTime taskDate;

  @override
  void didChangeDependencies() {
    var outputFormat = DateFormat('dd/MM/yyyy');
    taskDate =
        DateTime.fromMillisecondsSinceEpoch(widget.task.date, isUtc: true);
    var outputDate = outputFormat.format(taskDate);

    date = "$outputDate - ";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.C_2A2E3D,
        ),
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.task.title,
                      style: MyTextStyle.ubuntuMedium.copyWith(height: 1.4),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          date,
                          style:
                              MyTextStyle.ubuntuRegular.copyWith(fontSize: 10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: widget.task.status == "done"
                                ? MyColors.green
                                : MyColors.orange,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            widget.task.status == "done"
                                ? "Done"
                                : "In Progress",
                            style: MyTextStyle.ubuntuRegular
                                .copyWith(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: widget.onTapEdit,
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset(
                        MyIcons.edit,
                        width: 20,
                        height: 20,
                        color: MyColors.green,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: widget.onTapDelete,
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset(
                        MyIcons.trash,
                        width: 20,
                        height: 20,
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
