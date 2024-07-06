import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/GlobaWidget/taskItem/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';
import 'package:apiinntrigation/Screens/createNewTask/index.dart';
import 'package:apiinntrigation/Utility/app_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List newTaskList = [];
  List newTaskListCount = [];
  bool _isLodingNewTasks = false;
  bool _isLodingCount = false;

  final Map<String, bool> _isLoadingDeleteMap = {};
  final Map<String, bool> _isLoadingUpdateMap = {};
  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskCount();
  }

  Future<void> _getNewTask() async {
    _isLodingNewTasks = true;
    setState(() {});

    final NetworkResponse response = await ApiCall.getApiCall(Api.newTasks);

    newTaskList = response.responseData['data'];

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
                _getNewTask();
                _getTaskCount();
              },
              child: Visibility(
                visible: _isLodingNewTasks == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: newTaskList.isEmpty
                    ? const Center(child: Text('No data found'))
                    : ListView.builder(
                        itemCount: newTaskList.length,
                        itemBuilder: (context, index) {
                          final item = newTaskList[index];
                          final parsedDate = DateFormat('dd-MM-yyyy')
                              .parse(item['createdDate']!);
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(parsedDate);
                          return TaskItem(
                            title:
                                newTaskList[index]['title'].toUpperCase() ?? '',
                            description:
                                newTaskList[index]['description'] ?? '',
                            date: formattedDate,
                            color: AppColors.cardColorOne,
                            buttontitle: 'New',
                            onClick: () {
                              _deleteTask(newTaskList[index]['_id']);
                            },
                            deleLoding: _isLoadingDeleteMap[newTaskList[index]
                                    ['_id']] ??
                                false,
                            id: newTaskList[index]['_id'],
                            onUpdate: _updatStatusTask,
                            updateLoding: _isLoadingUpdateMap[newTaskList[index]
                                    ['_id']] ??
                                false,
                          );
                        }),
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewTask(),
      ),
    );

    if (result) {
      _getNewTask();
      _getTaskCount();
    }
  }

  Future<void> _deleteTask(id) async {
    _isLoadingDeleteMap[id] = true;
    setState(() {});
    final api = "${Api.baseUrl}/deleteTask/$id";

    final NetworkResponse response = await ApiCall.getApiCall(api);

    _isLoadingDeleteMap[id] = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, 'Task Deleted Successfully', false);
        _getNewTask();
        _getTaskCount();
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }

  Future<void> _updatStatusTask(id, status) async {
    _isLoadingUpdateMap[id] = true;
    setState(() {});
    final api = "${Api.baseUrl}/updateTaskStatus/$id/$status";

    final NetworkResponse response = await ApiCall.getApiCall(api);

    _isLoadingUpdateMap[id] = false;

    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, 'Task Updated Successfully', false);
        _getNewTask();
        _getTaskCount();
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }
}
