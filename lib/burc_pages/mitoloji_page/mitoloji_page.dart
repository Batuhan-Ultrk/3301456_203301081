// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:burc_rehberi/burc_pages/mitoloji_page/mitoloji_detay_page.dart';
import 'package:burc_rehberi/modeller/mitolojiModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MitolojiPage extends StatefulWidget {
  const MitolojiPage({Key? key}) : super(key: key);

  @override
  State<MitolojiPage> createState() => _MitolojiPageState();
}

class _MitolojiPageState extends State<MitolojiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, 'Burc Listesi');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 35,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Mitoloji',
          style: style(25, Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<MitolojiModel>>(
          future: mitolojiJsonOku(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MitolojiModel> mitolojiListe = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: mitolojiListe.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MitolojiDetayPage(
                              MListe: mitolojiListe,
                              baslik: mitolojiListe[index].burc[0].baslik,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: DecorationCreate(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(35),
                            elevation: 5,
                            child: Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              width: double.infinity,
                              height: 592,
                              child: Column(
                                children: [
                                  Text(mitolojiListe[index].burc[0].baslik,
                                      style: style(
                                        22,
                                        Colors.purple,
                                      ),
                                      textAlign: TextAlign.center),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 250,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/mitoloji_image/${mitolojiListe[index].burc[0].burc}1.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    width: double.infinity,
                                    //height: 230,
                                    child: Text(
                                      mitolojiListe[index].burc[0].detay1,
                                      style: style(15, Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Devamı İçin Tıklanıyız...',
                                    style: style(
                                      12,
                                      Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List<MitolojiModel>> mitolojiJsonOku() async {
    var okunanString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/burc_mitoloji.json');
    var jsonObject = jsonDecode(okunanString);
    List<MitolojiModel> mitoloji =
        (jsonObject as List).map((e) => MitolojiModel.fromMap(e)).toList();
    return mitoloji;
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
