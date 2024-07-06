import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/GlobaWidget/taskItem/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  List inProgressTaskList = [];

  bool _isLoding = false;

  final Map<String, bool> _isLoadingDeleteMap = {};
  final Map<String, bool> _isLoadingUpdateMap = {};

  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  Future<void> _getProgressTask() async {
    _isLoding = true;
    setState(() {});

    final NetworkResponse response = await ApiCall.getApiCall(Api.progressTask);

    inProgressTaskList = response.responseData['data'];

    _isLoding = false;

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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getProgressTask();
              },
              child: Visibility(
                visible: _isLoding == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: inProgressTaskList.isEmpty
                    ? const Center(child: Text('No data found'))
                    : ListView.builder(
                        itemCount: inProgressTaskList.length,
                        itemBuilder: (context, index) {
                          final item = inProgressTaskList[index];
                          final parsedDate = DateFormat('dd-MM-yyyy')
                              .parse(item['createdDate']!);
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(parsedDate);
                          return TaskItem(
                            title: inProgressTaskList[index]['title']
                                    .toUpperCase() ??
                                '',
                            description: inProgressTaskList[index]
                                        ['description']
                                    .toUpperCase() ??
                                '',
                            date: formattedDate,
                            color: Colors.pink,
                            buttontitle: "Progress",
                            onClick: () {
                              _deleteTask(inProgressTaskList[index]['_id']);
                            },
                            deleLoding: _isLoadingDeleteMap[
                                    inProgressTaskList[index]['_id']] ??
                                false,
                            id: inProgressTaskList[index]['_id'],
                            onUpdate: _updatStatusTask,
                            updateLoding: _isLoadingUpdateMap[
                                    inProgressTaskList[index]['_id']] ??
                                false,
                          );
                        }),
              ),
            ),
          )
        ],
      ),
    );
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
      }

      _getProgressTask();
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
        _getProgressTask();
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }
}
