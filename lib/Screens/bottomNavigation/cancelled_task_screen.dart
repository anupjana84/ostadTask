import 'package:apiinntrigation/Api/api_call.dart';
import 'package:apiinntrigation/Api/index.dart';
import 'package:apiinntrigation/GlobaWidget/taskItem/index.dart';
import 'package:apiinntrigation/HelperMethod/imdex.dart';
import 'package:apiinntrigation/Models/response_model.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  List cancelledTaskList = [];

  bool _isLoding = false;

  final Map<String, bool> _isLoadingDeleteMap = {};
  final Map<String, bool> _isLoadingUpdateMap = {};
  @override
  void initState() {
    super.initState();
    _getCancleTask();
  }

  Future<void> _getCancleTask() async {
    _isLoding = true;
    setState(() {});

    final NetworkResponse response =
        await ApiCall.getApiCall(Api.cancelledTask);

    cancelledTaskList = response.responseData['data'];

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
                _getCancleTask();
              },
              child: Visibility(
                visible: _isLoding == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: cancelledTaskList.isEmpty
                    ? const Center(child: Text('No data found'))
                    : ListView.builder(
                        itemCount: cancelledTaskList.length,
                        itemBuilder: (context, index) {
                          final item = cancelledTaskList[index];
                          final parsedDate = DateFormat('dd-MM-yyyy')
                              .parse(item['createdDate']!);
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(parsedDate);
                          return TaskItem(
                            title: cancelledTaskList[index]['title']
                                    .toUpperCase() ??
                                '',
                            description: cancelledTaskList[index]['description']
                                    .toUpperCase() ??
                                '',
                            date: formattedDate,
                            color: Colors.red,
                            buttontitle: 'Cancelled',
                            onClick: () {
                              _deleteTask(cancelledTaskList[index]['_id']);
                            },
                            deleLoding: _isLoadingDeleteMap[
                                    cancelledTaskList[index]['_id']] ??
                                false,
                            id: cancelledTaskList[index]['_id'],
                            onUpdate: _updatStatusTask,
                            updateLoding: _isLoadingUpdateMap[
                                    cancelledTaskList[index]['_id']] ??
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

      _getCancleTask();
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
        _getCancleTask();
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, response.errorMessage ?? 'Data get Fail', true);
      }
    }
  }
}
