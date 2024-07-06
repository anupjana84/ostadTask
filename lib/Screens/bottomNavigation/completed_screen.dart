import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/GlobaWidget/taskItem/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List completTaskList = [];

  bool _isLoding = false;

  final Map<String, bool> _isLoadingDeleteMap = {};
  final Map<String, bool> _isLoadingUpdateMap = {};

  @override
  void initState() {
    super.initState();
    _getCompleteTask();
  }

  Future<void> _getCompleteTask() async {
    _isLoding = true;
    setState(() {});

    final NetworkResponse response =
        await ApiCall.getApiCall(Api.completedTask);

    completTaskList = response.responseData['data'];

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
                _getCompleteTask();
              },
              child: Visibility(
                visible: _isLoding == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: completTaskList.isEmpty
                    ? const Center(child: Text('No data found'))
                    : ListView.builder(
                        itemCount: completTaskList.length,
                        itemBuilder: (context, index) {
                          final item = completTaskList[index];
                          final parsedDate = DateFormat('dd-MM-yyyy')
                              .parse(item['createdDate']!);
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(parsedDate);
                          return TaskItem(
                            title:
                                completTaskList[index]['title'].toUpperCase() ??
                                    '',
                            description: completTaskList[index]['description']
                                    .toUpperCase() ??
                                '',
                            date: formattedDate,
                            color: Colors.green,
                            buttontitle: 'Completed',
                            onClick: () {
                              _deleteTask(completTaskList[index]['_id']);
                            },
                            deleLoding: _isLoadingDeleteMap[
                                    completTaskList[index]['_id']] ??
                                false,
                            id: completTaskList[index]['_id'],
                            onUpdate: _updatStatusTask,
                            updateLoding: _isLoadingUpdateMap[
                                    completTaskList[index]['_id']] ??
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

      _getCompleteTask();
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
        _getCompleteTask();
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }
}
