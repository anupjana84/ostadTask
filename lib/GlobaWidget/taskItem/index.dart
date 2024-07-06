import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

class TaskItem extends StatefulWidget {
  final String title;
  final Function onClick;
  final Function onUpdate;
  final bool deleLoding;
  final bool updateLoding;
  final String id;

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
    required this.onClick,
    required this.deleLoding,
    required this.id,
    required this.onUpdate,
    required this.updateLoding,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  String dropdownValue = "";
  List<String> statusList = ['New', 'Progress', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.buttontitle;
  }

  @override
  Widget build(BuildContext context) {
    final String truncatedDescription = widget.description.length > 50
        ? '${widget.description.substring(0, 50)}...'
        : widget.description;
    return Container(
      height: 180,
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
                      widget.title,
                      style: const TextStyle(fontSize: 24.00),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.00),
                      child: Wrap(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: truncatedDescription,
                              style: const TextStyle(color: Colors.black),
                              children: widget.description.length > 50
                                  ? [
                                      TextSpan(
                                        text: ' Read more',
                                        style:
                                            const TextStyle(color: Colors.red),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _showDialog(widget.description);
                                          },
                                      ),
                                    ]
                                  : [],
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.00),
                    child: Text(
                      "Date ${widget.date}",
                      style: const TextStyle(
                          fontSize: 16.00, fontWeight: FontWeight.w500),
                    ),
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
                            backgroundColor: widget.color,
                            label: Text(
                              widget.buttontitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(0, 96, 93, 93),
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Visibility(
                              visible: widget.updateLoding == false,
                              replacement: const CircularProgressIndicator(),
                              child: PopupMenuButton<String>(
                                icon: const Icon(Icons.edit),
                                onSelected: (String selectedValue) {
                                  dropdownValue = selectedValue;
                                  widget.onUpdate(widget.id, selectedValue);
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return statusList.map((String value) {
                                    return PopupMenuItem<String>(
                                      value: value,
                                      child: ListTile(
                                        title: Text(value),
                                        trailing: dropdownValue == value
                                            ? const Icon(Icons.done)
                                            : null,
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),

                            //  Icon(
                            //   Icons.edit,
                            //   color: AppColors.cardColorOne,
                            // ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: widget.deleLoding == false,
                              replacement: const Center(
                                  child: CircularProgressIndicator()),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  widget.onClick();
                                },
                              ),
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

  void _showDialog(ttile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            Container(
              padding: const EdgeInsets.all(10.00),
              width: double.infinity,
              height: 300,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    Text(
                      ttile,
                      style: const TextStyle(
                          fontSize: 16.00, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
