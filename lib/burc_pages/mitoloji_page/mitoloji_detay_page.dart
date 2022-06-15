// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:burc_rehberi/modeller/mitolojiModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MitolojiDetayPage extends StatelessWidget {
  final baslik;
  final index;
  List<MitolojiModel> MListe;
  MitolojiDetayPage(
      {required this.MListe,
      required this.baslik,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Text(
          baslik,
          style: style(
            17,
            Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: DecorationCreate(),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Text(
                          MListe[index].burc[0].detay2,
                          style: style(
                            18,
                            Colors.white,
                          ),
                        ),
                        width: 300,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Image.asset(
                        'assets/images/mitoloji_image/${MListe[index].burc[0].burc}2.jpg',
                        fit: BoxFit.cover,
                      ),
                      width: 300,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Text(
                          MListe[index].burc[0].detay3,
                          style: style(
                            18,
                            Colors.white,
                          ),
                        ),
                        width: 300,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
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

  BoxDecoration DecorationCreate() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 5,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(35),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Colors.purple, Colors.orangeAccent],
      ),
    );
  }
}
