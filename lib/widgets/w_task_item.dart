import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';

class WTaskItem extends StatelessWidget {
  WTaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.C_2A2E3D,
        borderRadius: BorderRadius.circular(10),
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
                    "This is my task",
                    style: MyTextStyle.ubuntuMedium.copyWith(height: 1.4),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "03.07.2021 - ",
                        style: MyTextStyle.ubuntuRegular.copyWith(fontSize: 10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Done",
                          style:
                              MyTextStyle.ubuntuRegular.copyWith(fontSize: 10),
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
                    onTap: () {},
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
                    onTap: () {},
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
    );
  }
}
