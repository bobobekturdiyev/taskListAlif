import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';
import 'package:task_list_alif/models/page_enum.dart';
import 'package:flutter/material.dart';
import 'package:task_list_alif/widgets/w_task_item.dart';

class DataScreen extends StatefulWidget {
  WPage page;
  DataScreen({Key? key, required this.page}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          WTaskItem(),
          WTaskItem(),
          WTaskItem(),
        ],
      ),
    );
  }
}
