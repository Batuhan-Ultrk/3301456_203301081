// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BurcItem extends StatelessWidget {
  final listenenBurc;
  const BurcItem({required this.listenenBurc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: Image.asset(
            "assets/images/" + listenenBurc.burcKucukResim,
          ),
          title: Text(
            listenenBurc.burcAdi,
            style: style(22),
          ),
          subtitle: Text(
            listenenBurc.burcTarihi,
            style: style2(15),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.lightBlue,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'PageCreate', arguments: listenenBurc);
          },
        ),
      ),
    );
  }

  TextStyle style(double size) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );
  }

  TextStyle style2(double size) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.yellow,
    );
  }
}
