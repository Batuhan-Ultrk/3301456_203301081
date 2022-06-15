// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:burc_rehberi/data/burc_yorum_detay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageCreate2 extends StatelessWidget {
  final burc;
  List<String> burcDetayBaslik = BurcDetay.BURC_GENEL_YORUM_BASLIK;
  List<String> burcDetay = [];
  PageCreate2({required String this.burc, Key? key}) : super(key: key);

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buyukburc = burc.toUpperCase();
    if (burc == 'Koc') {
      burcDetay = BurcDetay.Koc_BURC_GENEL_YORUM;
    } else if (burc == 'Boga') {
      burcDetay = BurcDetay.Boga_BURC_GENEL_YORUM;
    } else if (burc == 'Ikizler') {
      burcDetay = BurcDetay.Ikizler_BURC_GENEL_YORUM;
    } else if (burc == 'Yengec') {
      burcDetay = BurcDetay.Yengec_BURC_GENEL_YORUM;
    } else if (burc == 'Aslan') {
      burcDetay = BurcDetay.Aslan_BURC_GENEL_YORUM;
    } else if (burc == 'Basak') {
      burcDetay = BurcDetay.Basak_BURC_GENEL_YORUM;
    } else if (burc == 'Terazi') {
      burcDetay = BurcDetay.Terazi_BURC_GENEL_YORUM;
    } else if (burc == 'Akrep') {
      burcDetay = BurcDetay.Akrep_BURC_GENEL_YORUM;
    } else if (burc == 'Yay') {
      burcDetay = BurcDetay.Yay_BURC_GENEL_YORUM;
    } else if (burc == 'Oglak') {
      burcDetay = BurcDetay.Oglak_BURC_GENEL_YORUM;
    } else if (burc == 'Kova') {
      burcDetay = BurcDetay.Kova_BURC_GENEL_YORUM;
    } else if (burc == 'Balik') {
      burcDetay = BurcDetay.Balik_BURC_GENEL_YORUM;
    }

    return PageCreate(context, burc, buyukburc, burcDetayBaslik, burcDetay);
  }

  Scaffold PageCreate(BuildContext context, burc, buyukburc,
      List<dynamic> burcDetayBaslik, List<dynamic> burcDetay) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'Burc Listesi');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Text(
          burc + ' Burcu Genel Yorum',
          textAlign: TextAlign.center,
          style: style(21, Colors.white),
        ),
      ),
      body: Container(
        decoration: DecorationCreate(),
        child: ListView.builder(
          itemCount: burcDetayBaslik.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              backgroundColor: Colors.orange,
              title: Text(
                (buyukburc + burcDetayBaslik[index]),
                style: style(20, Colors.deepPurple.shade900),
                textAlign: TextAlign.center,
              ),
              leading: IconCreate(Icons.notes_rounded),
              trailing: IconCreate(Icons.format_line_spacing_rounded),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    burcDetay[index],
                    style: style(18, Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Icon IconCreate(IconData icons) {
    return Icon(
      icons,
      size: 35,
      color: Colors.white,
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
