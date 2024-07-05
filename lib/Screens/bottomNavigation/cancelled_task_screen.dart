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

  @override
  void initState() {
    super.initState();
    _getNewTask();
  }

  Future<void> _getNewTask() async {
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
                _getNewTask();
              },
              child: Visibility(
                visible: _isLoding == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                    itemCount: cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      final item = cancelledTaskList[index];
                      final parsedDate =
                          DateFormat('dd-MM-yyyy').parse(item['createdDate']!);
                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(parsedDate);
                      return TaskItem(
                          title:
                              cancelledTaskList[index]['title'].toUpperCase() ??
                                  '',
                          description: cancelledTaskList[index]['description']
                                  .toUpperCase() ??
                              '',
                          date: formattedDate,
                          color: Colors.red,
                          buttontitle: 'Cancelled');
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
