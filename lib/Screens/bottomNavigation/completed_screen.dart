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

  @override
  void initState() {
    super.initState();
    _getNewTask();
  }

  Future<void> _getNewTask() async {
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
                _getNewTask();
              },
              child: Visibility(
                visible: _isLoding == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                    itemCount: completTaskList.length,
                    itemBuilder: (context, index) {
                      final item = completTaskList[index];
                      final parsedDate =
                          DateFormat('dd-MM-yyyy').parse(item['createdDate']!);
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
                          buttontitle: 'Completed');
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
