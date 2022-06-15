// ignore_for_file: must_be_immutable

import 'package:burc_rehberi/data/local_Database.dart';
import 'package:burc_rehberi/main.dart';
import 'package:burc_rehberi/modeller/to_do_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ToDoItem extends StatefulWidget {
  Task task;
  ToDoItem({required this.task, Key? key}) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  final TextEditingController _taskNameControler = TextEditingController();
  late LocalDatabase _localDatabase;
  @override
  void initState() {
    super.initState();
    _localDatabase = locator<LocalDatabase>();
  }

  @override
  Widget build(BuildContext context) {
    _taskNameControler.text = widget.task.task;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.completed = !widget.task.completed;
              _localDatabase.updateTask(task: widget.task);
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.task.completed ? Colors.green : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  )),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          title: widget.task.completed
              ? Text(
                  widget.task.task,
                  style: style(
                    18,
                    Colors.grey,
                    decor: TextDecoration.lineThrough,
                  ),
                )
              : TextField(
                  controller: _taskNameControler,
                  minLines: 1,
                  maxLines: null,
                  readOnly: false,
                  style: style(
                    18,
                    Colors.black,
                  ),
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSubmitted: (data) {
                    if (data.isNotEmpty) {
                      widget.task.task = data;
                      _localDatabase.updateTask(task: widget.task);
                    }
                  },
                ),
          trailing: Text(
            DateFormat('hh:mm a').format(widget.task.time),
            style: style(
              15,
              Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  TextStyle style(double size, Color colorss, {TextDecoration? decor}) {
    return GoogleFonts.quicksand(
      decoration: decor,
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }
}
