// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:burc_rehberi/data/burc_uyum_detay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BurcUyumCreate extends StatelessWidget {
  final index;
  const BurcUyumCreate({required this.index, Key? key}) : super(key: key);

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 27,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              'Burc Uyumu',
            );
          },
        ),
        title: Text(
          BurcUyum.UYUM_AD[index],
          style: style(16, Colors.black),
        ),
      ),
      body: Container(
        decoration: DecorationCreate(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Create(
                index,
                'UYUM YÜZDESİ',
                BurcUyum.UYUM_YUZDE[index],
              ),
              Create(
                index,
                'BURÇLARIN UYUM YORUMU',
                BurcUyum.UYUM_DETAY[index],
              ),
              Create(
                index,
                'UYUM YÜZDESİ YORUMU',
                BurcUyum.UYUM_YUZDE_DETAY[index],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Create(index, String textTitle, String text) {
    return ExpansionTile(
      backgroundColor: Colors.transparent,
      title: Text(
        textTitle,
        style: style(20, Colors.white),
        textAlign: TextAlign.center,
      ),
      leading: IconCreate(
        Icons.notes_rounded,
      ),
      trailing: IconCreate(
        Icons.format_line_spacing_rounded,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: style(18, Colors.black),
          ),
        ),
      ],
    );
  }

  Icon IconCreate(IconData icons) {
    return Icon(
      icons,
      size: 35,
      color: Colors.indigo,
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
}
