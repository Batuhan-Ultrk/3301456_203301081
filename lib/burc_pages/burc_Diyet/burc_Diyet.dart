// ignore_for_file: file_names

import 'package:burc_rehberi/data/burc_diyet_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class DiyetPage extends StatelessWidget {
  const DiyetPage({Key? key}) : super(key: key);

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
        title: Text(
          'Burç Diyetleri',
          style: style(21, Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              'Burc Listesi',
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.purple, Colors.orangeAccent],
          ),
        ),
        child: ListView.builder(
          itemCount: BurcDiyet.BURC_DIYET_BASLIK.length,
          itemBuilder: (BuildContext context, int index) {
            List<String> baslikdetay = [
              BurcDiyet.BURC_DIYET_BASLIK[index],
              BurcDiyet.BURC_DIYET_DETAY[index],
              BurcDiyet.BURC_ADLARI[index],
            ];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onLongPress: () {
                      EasyLoading.showToast(
                        BurcDiyet.BURC_DIYET_BASLIK[index],
                        duration: const Duration(seconds: 3),
                        toastPosition: EasyLoadingToastPosition.center,
                      );
                    },
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'BurcDiyetCreate',
                        arguments: baslikdetay,
                      );
                    },
                    label: Text(
                      BurcDiyet.BURC_DIYET_BASLIK[index],
                      style: style(18, Colors.white),
                    ),
                    icon: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      primary: Colors.transparent,
                      shape: const StadiumBorder(),
                      elevation: 17,
                      fixedSize: const Size(400, 50),
                      // shadowColor: Colors.orange,
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
