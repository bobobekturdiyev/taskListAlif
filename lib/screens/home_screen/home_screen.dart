import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_list_alif/data/util/colors.dart';
import 'package:task_list_alif/data/util/icons.dart';
import 'package:task_list_alif/data/util/style.dart';
import 'package:task_list_alif/models/page_enum.dart';
import 'package:task_list_alif/screens/add_task_screen/add_task_screen.dart';
import 'package:task_list_alif/screens/data_screen/bloc/data_screen_bloc.dart';
import 'package:task_list_alif/screens/data_screen/data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DataScreenBloc dataScreenBloc;

  @override
  void initState() {
    dataScreenBloc = DataScreenBloc();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    dataScreenBloc.close();
    super.dispose();
  }

  void _handleTabSelection() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: dataScreenBloc,
      child: Scaffold(
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
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) => AddTaskScreen(
                          dataScreenBloc: dataScreenBloc,
                        )));
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  MyIcons.plus,
                  color: MyColors.white,
                  width: 18,
                  height: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        body: BlocBuilder<DataScreenBloc, DataScreenState>(
          builder: (context, state) {
            if (state is DataScreenInitial || state is TaskLoading) {
              return CupertinoActivityIndicator();
            } else if (state is TaskLoadedState) {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  DataScreen(
                    dataScreenBloc: dataScreenBloc,
                    taskList: state.taskList,
                  ),
                  DataScreen(
                    dataScreenBloc: dataScreenBloc,
                    taskList: state.doneList,
                  ),
                  DataScreen(
                    dataScreenBloc: dataScreenBloc,
                    taskList: state.inProgressList,
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          indicatorColor: MyColors.transparent,
          labelColor: MyColors.primaryColor,
          unselectedLabelColor: MyColors.white,
          tabs: [
            Tab(
              text: "All",
              icon: SvgPicture.asset(
                MyIcons.list,
                color: _tabController.index == 0
                    ? MyColors.primaryColor
                    : Colors.white,
                width: 24,
                height: 24,
              ),
            ),
            Tab(
              text: "Done",
              icon: SvgPicture.asset(
                MyIcons.tick,
                color: _tabController.index == 1
                    ? MyColors.primaryColor
                    : Colors.white,
                width: 24,
                height: 24,
              ),
            ),
            Tab(
              text: "In progress",
              icon: SvgPicture.asset(
                MyIcons.waiting,
                color: _tabController.index == 2
                    ? MyColors.primaryColor
                    : Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
