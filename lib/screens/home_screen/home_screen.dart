import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        title: Text(
          "Task List",
          style: MyTextStyle.ubuntuBold.copyWith(fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                MyIcons.plus,
                color: MyColors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            text: "All",
            icon: SvgPicture.asset(
              MyIcons.list,
              width: 24,
              height: 24,
            ),
          ),
          Tab(
            text: "Done",
            icon: SvgPicture.asset(
              MyIcons.tick,
              width: 24,
              height: 24,
            ),
          ),
          Tab(
            text: "In progress",
            icon: SvgPicture.asset(
              MyIcons.waiting,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
