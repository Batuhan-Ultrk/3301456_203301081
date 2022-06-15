// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:burc_rehberi/data/local_Database.dart';
import 'package:burc_rehberi/main.dart';
import 'package:burc_rehberi/modeller/to_do_model.dart';
import 'package:burc_rehberi/to_do_page/search_delegate.dart';
import 'package:burc_rehberi/to_do_page/to_do_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ToDoPage extends StatefulWidget {
  String username;
  ToDoPage({required this.username, Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  late List<Task> _allTasks;
  late LocalDatabase _localDatabase;
  @override
  void initState() {
    super.initState();
    _localDatabase = locator<LocalDatabase>();
    _allTasks = <Task>[];
    _getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            addCreate();
          },
          child: Text(
            'To Do',
            style: style(
              25,
              Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 28,
          ),
          tooltip: 'Profile Dön',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              searchCreate();
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 30,
            ),
            tooltip: 'Arama',
          ),
          IconButton(
            onPressed: () {
              addCreate();
            },
            icon: const Icon(
              Icons.add_task_rounded,
              color: Colors.white,
              size: 30,
            ),
            tooltip: 'Ekleme',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => _infoCreate());
            },
            icon: const Icon(
              Icons.info_outlined,
              color: Colors.white,
              size: 30,
            ),
            tooltip: 'İnfo',
          ),
        ],
      ),
      body: _allTasks.isNotEmpty
          ? Container(
              decoration: DecorationCreate(),
              child: ListView.builder(
                itemCount: _allTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(_allTasks[index].id),
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete_forever_rounded,
                          size: 28,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Görev Siliniyor',
                          style: style(
                            17,
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onDismissed: (directon) {
                      var oanki = _allTasks[index];
                      _allTasks.removeAt(index);
                      _localDatabase.deleteTask(task: oanki);
                      setState(() {});
                    },
                    child: ToDoItem(task: _allTasks[index]),
                  );
                },
              ),
            )
          : Container(
              decoration: DecorationCreate(),
              child: Center(
                child: Text(
                  'Haydi ${widget.username}! Bugünün Görevlerini Ekle.',
                  style: style(
                    18,
                    Colors.black,
                  ),
                ),
              ),
            ),
    );
  }

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  Future<void> searchCreate() async {
    await showSearch(
      context: context,
      delegate: SearchDelegateCreate(allTasks: _allTasks),
    );
    _getAllTask();
  }

  void addCreate() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextFieldCreate(
              'Eklenecek Görev',
              TextInputType.text,
              Icons.add,
            ),
          ),
        );
      },
    );
  }

  TextField TextFieldCreate(
    String text,
    TextInputType keyboardType,
    IconData shape,
  ) {
    return TextField(
      autofocus: true,
      readOnly: false,
      style: style(18, Colors.white),
      cursorColor: Colors.black,
      cursorWidth: 2,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      decoration: DecoratinStyle(text, shape),
      onSubmitted: (data) {
        Navigator.pop(context);
        if (data.isNotEmpty) {
          DatePicker.showTimePicker(
            context,
            showSecondsColumn: false,
            onConfirm: (time) async {
              var taskAdd = Task.Create(task: data, time: time);
              await _localDatabase.addTask(task: taskAdd);
              setState(() {
                _allTasks.add(taskAdd);
              });
            },
          );
        }
      },
    );
  }

  InputDecoration DecoratinStyle(String Data, IconData DataIcon) {
    return InputDecoration(
      errorStyle: style(12, Colors.orange),
      prefix: Icon(
        DataIcon,
        color: Colors.white,
        size: 30,
      ),
      border: const OutlineInputBorder(
        gapPadding: 5,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        borderSide: BorderSide.none,
      ),
      labelText: Data,
      labelStyle: style(17, Colors.black),
      hintText: Data,
      hintStyle: style(18, Colors.black),
      filled: true,
      fillColor: Colors.amber,
    );
  }

  BoxDecoration DecorationCreate() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Colors.purple, Colors.orangeAccent],
      ),
    );
  }

  Future<void> _getAllTask() async {
    _allTasks = await _localDatabase.getAllTask();
    setState(() {});
  }

  _infoCreate() {
    return AlertDialog(
      title: const Text("To Do Kullanımı"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("- Artı ikonuna tıklayarak görev eklmesi yapabilirsiniz."),
          Text("- Arama ikonuna tıklayrak görev araması yapabilirsiniz."),
          Text(
              "- Yapılan görevleri beyaz yuvarlağa tıklayarak yapıldı şeklinde işaretleyebilirsiniz."),
          Text(
              "- Eklenmiş görev adında değişiklik yapmak için yapıldı olarak işaretlemeden görev adına dokunarak değişiklik yapabilirsiniz."),
          Text("- Görevleri silmek için sağa yada sola kaydırabilirsiniz."),
          Text(
              "- Uygulamaya eklenen görevler günlüktür her günün sonunda saat 00.00 olduktan sonra otomatik olarak silinecektir."),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
