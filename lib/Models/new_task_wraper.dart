import 'package:apiinntrigation/Models/task_item.dart';

class NewTaskWraper {
  String? status;
  List<TaskItemModel>? newTasWraperkList;

  NewTaskWraper({this.newTasWraperkList});

  NewTaskWraper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      newTasWraperkList = <TaskItemModel>[];
      json['data'].forEach((v) {
        newTasWraperkList!.add(TaskItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (newTasWraperkList != null) {
      data['data'] = newTasWraperkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
