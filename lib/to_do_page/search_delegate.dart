// ignore_for_file: non_constant_identifier_names

import 'package:burc_rehberi/data/local_Database.dart';
import 'package:burc_rehberi/main.dart';
import 'package:burc_rehberi/modeller/to_do_model.dart';
import 'package:burc_rehberi/to_do_page/to_do_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchDelegateCreate extends SearchDelegate {
  final List<Task> allTasks;

  SearchDelegateCreate({required this.allTasks});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
          size: 28,
        ),
        tooltip: 'Temizle',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 28,
      ),
      tooltip: 'Geri',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filterList = allTasks
        .where((element) =>
            element.task.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filterList.isNotEmpty
        ? Container(
            decoration: DecorationCreate(),
            child: ListView.builder(
              itemCount: filterList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(filterList[index].id),
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
                  onDismissed: (directon) async {
                    var oanki = filterList[index];
                    filterList.removeAt(index);
                    await locator<LocalDatabase>().deleteTask(task: oanki);
                  },
                  child: ToDoItem(task: filterList[index]),
                );
              },
            ),
          )
        : Center(
            child: Container(
              decoration: const BoxDecoration(),
              child: Text(
                'Aranan Kelime Bulunamadı.',
                style: style(
                  25,
                  Colors.red,
                ),
              ),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: DecorationCreate(),
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

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }
}
