import 'dart:async';

import 'package:apiinntrigation/Api/ApiCallViaGetX/new_task_list_controller.dart';
import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/delete_task_controller.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/GlobaWidget/taskItem/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Screens/createNewTask/index.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  List newTaskList = [];
  List newTaskListCount = [];
  bool _isLodingNewTasks = false;
  bool _isLodingCount = false;

  final Map<String, bool> _isLoadingDeleteMap = {};
  final Map<String, bool> _isLoadingUpdateMap = {};

  @override
  void initState() {
    super.initState();
    // _getNewTask();
    // _getTaskCount();
    _initCall();
  }

  _initCall() {
    Get.find<NewTaskController>().getdata(Api.cancelledTask);
  }

  Future<void> _getNewTask() async {
    _isLodingNewTasks = true;
    setState(() {});

    final NetworkResponse response = await ApiCall.getApiCall(Api.newTasks);
    print(response.responseData);

    _isLodingNewTasks = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }

  Future<void> _getTaskCount() async {
    _isLodingCount = true;
    setState(() {});

    final NetworkResponse response =
        await ApiCall.getApiCall(Api.taskStatusCount);

    newTaskListCount = response.responseData['data'];
    _isLodingCount = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5.00),
            height: 100,
            child: _countScrollView(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // _getNewTask();
                // _getTaskCount();
                _initCall();
              },
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.isLoding == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: newTaskController.newTaskList.isEmpty
                        ? const Center(child: Text('No data found'))
                        : ListView.builder(
                            itemCount: newTaskController.newTaskList.length,
                            itemBuilder: (context, index) {
                              final item = newTaskController.newTaskList[index];
                              final parsedDate = item.createdDate != null
                                  ? DateFormat('dd-MM-yyyy')
                                      .parse(item.createdDate!)
                                  : DateTime.now();
                              final formattedDate =
                                  DateFormat('dd/MM/yyyy').format(parsedDate);

                              return TaskItem(
                                  taskItemModel:
                                      newTaskController.newTaskList[index],
                                  color: AppColors.cardColorOne,
                                  buttontitle: 'Cancelled',
                                  onUpdate: _initCall);
                            },
                          ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _creatNewTask,
        backgroundColor: AppColors.cardColorOne,
        foregroundColor: AppColors.backgroundColorTwo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  _countScrollView() {
    return Visibility(
      visible: _isLodingCount == false,
      replacement: const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: newTaskListCount.map((e) {
          return SizedBox(
            width: 100,
            height: 100,
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    e['sum'].toString(),
                  ),
                  Text(
                    e['_id'].toString(),
                  )
                ],
              ),
            ),
          );
        }).toList()),
      ),
    );
  }

  void _creatNewTask() async {
    Get.to(() => const CreateNewTask());
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const CreateNewTask(),
    //   ),
    //);

    // if (result) {
    //   _getNewTask();
    //   _getTaskCount();
    // }
  }

  Future<void> _deleteTask(id) async {
    _isLoadingDeleteMap[id] = true;
    final DeletedController deletedController = Get.find<DeletedController>();
    final NewTaskController newTaskController = Get.find<NewTaskController>();
    final api = "${Api.baseUrl}/deleteTask/$id";
    final bool result = await deletedController.delstedTask(api);
    if (result) {
      if (mounted) {
        showSnackMessage(context, 'Task Deleted', true);

        Timer(const Duration(seconds: 1), () {
          newTaskController.getdata(Api.cancelledTask);
        });
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Delete Task fail ', false);
      }
    }
// VOID
// void _updatStatusTask(){}
    Future<void> _updatStatusTask(id, status) async {
      // final DeletedController deletedController =Get.find()
      // final api = "${Api.baseUrl}/updateTaskStatus/$id/$status";

      // final NetworkResponse response = await ApiCall.getApiCall(api);

      // _isLoadingUpdateMap[id] = false;

      // if (mounted) {
      //   setState(() {});
      // }

      // if (response.isSuccess) {
      //   if (mounted) {
      //     showSnackMessage(context, 'Task Updated Successfully', false);
      //     _getNewTask();
      //     _getTaskCount();
      //   }
      // } else {
      //   if (mounted) {
      //     showSnackMessage(
      //         context, response.errorMessage ?? 'Data get Fail', true);
      //   }
      // }
    }
  }
}
