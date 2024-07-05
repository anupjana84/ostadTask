import 'package:flutter/material.dart';
import 'package:apiinntrigation/Utility/app_color.dart';

class TaskItem extends StatelessWidget {
  final String title;

  final String description;
  final String date;
  final Color color;
  final String buttontitle;
  const TaskItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    required this.buttontitle,
  });

  @override
  Widget build(BuildContext context) {
    print(buttontitle);
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 12.00, right: 12.00, top: 10.00),
      child: Card(
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.00)),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.00),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 24.00),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(description),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(date),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.00),
                          child: Chip(
                            backgroundColor: color,
                            label: Text(
                              buttontitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(0, 96, 93, 93),
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.cardColorOne,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
