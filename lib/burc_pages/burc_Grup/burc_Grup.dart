// ignore_for_file: file_names, non_constant_identifier_names
// ignore: duplicate_ignore
import 'package:burc_rehberi/data/burc_grup_detay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GrupPage extends StatelessWidget {
  const GrupPage({Key? key}) : super(key: key);

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
              'Burc Listesi',
            );
          },
        ),
        title: Text(
          'Burç Grupları',
          style: style(21, Colors.white),
        ),
      ),
      body: Container(
        decoration: DecorationCreate(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: BurcGrup.BURC_GRUPLARI.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.transparent,
                elevation: 20,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: colorCreate(BurcGrup.BURC_GRUPLARI[index]),
                      leading: const Icon(
                        Icons.notes_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                      title: Text(
                        BurcGrup.BURC_GRUPLARI[index],
                        style: style(20, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          TextCreate(
                            index,
                            BurcGrup.BURC_GRUPLARI_UYELERI,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 4,
                            height: 20,
                          ),
                          TextCreate(
                            index,
                            BurcGrup.BURC_GRUPLARI_DETAY,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget TextCreate(int index, List<String> BURC) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        BURC[index],
        style: style(19, Colors.white),
      ),
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

  Color? colorCreate(String veri) {
    if (veri == 'SU GRUBU') {
      return Colors.blue.shade200;
    } else if (veri == 'HAVA GRUBU') {
      return Colors.green.shade200;
    } else if (veri == 'TOPRAK GRUBU') {
      return Colors.brown.shade500;
    } else {
      return Colors.red;
    }
  }
}
