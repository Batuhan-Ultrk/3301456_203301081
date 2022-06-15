// ignore_for_file: must_be_immutable, non_constant_identifier_names, file_names

import 'package:burc_rehberi/burc_items.dart';
import 'package:burc_rehberi/burc_pages/gunluk_yorum/gunluk_yorum_page.dart';
import 'package:burc_rehberi/data/strings.dart';
import 'package:burc_rehberi/drawer_page/drawe_page.dart';
import 'package:burc_rehberi/modeller/burc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class BurcListesi extends StatefulWidget {
  late List<Burc> tumBurclar = [];

  BurcListesi({Key? key}) : super(key: key) {
    tumBurclar = veriKaynaginiHazirla();
  }
  List<Burc> veriKaynaginiHazirla() {
    List<Burc> gecici = [];
    for (int i = 0; i < 12; i++) {
      var burcKucukResim =
          Strings.BURC_ADLARI[i].toLowerCase() + '${i + 1}.png';
      var burcBuyukResim =
          Strings.BURC_ADLARI[i].toLowerCase() + '_buyuk${i + 1}.png';
      Burc eklenecekBurc = Burc(
          Strings.BURC_ADLARI[i],
          Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i],
          burcKucukResim,
          burcBuyukResim);
      gecici.add(eklenecekBurc);
    }
    return gecici;
  }

  @override
  State<BurcListesi> createState() => _BurcListesiState();
}

class _BurcListesiState extends State<BurcListesi>
    with SingleTickerProviderStateMixin {
  late String _EMail,
      _Username,
      _PhoneNumber,
      _Gender,
      _DateOfBirth,
      _Age,
      _Burc,
      _AboutMe,
      _dateofregistration;
  late Animation animationGunlukYorum;
  late Animation animationGunlukYorumYazi;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    controller.addListener(
      () {
        setState(() {});
      },
    );

    controller.forward();
    controller.addStatusListener(
      (durum) {
        if (durum == AnimationStatus.completed) {
          controller.reverse().orCancel;
        } else if (durum == AnimationStatus.dismissed) {
          controller.forward().orCancel;
        }
      },
    );
    animationGunlukYorum =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animationGunlukYorumYazi =
        ColorTween(begin: Colors.white, end: Colors.orange.shade200).animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextStyle style(double size) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );
  }

  localDataRead() async {
    var preferences = const FlutterSecureStorage();
    _EMail = await preferences.read(key: 'E Mail') ?? "";
    _Username = await preferences.read(key: 'Username') ?? "";
    _PhoneNumber = await preferences.read(key: 'Phone Number') ?? "";
    _Gender = await preferences.read(key: 'Gender') ?? "";
    _DateOfBirth = await preferences.read(key: 'Date Of Birth') ?? "";
    _Age = await preferences.read(key: 'Age') ?? "";
    _Burc = await preferences.read(key: 'Burç') ?? "";
    _AboutMe = await preferences.read(key: 'About Me') ?? "";
    _dateofregistration =
        await preferences.read(key: 'date of registration') ?? "";

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text(
          'Burclar Listesi',
          style: style(21),
        ),
        actions: [
          IconButton(
            onPressed: () {
              List<String> detay = [
                _EMail,
                _Username,
                _PhoneNumber,
                _Gender,
                _DateOfBirth,
                _Age,
                _Burc,
                _AboutMe,
                _dateofregistration
              ];
              // print(detay);
              if (detay[0] == '') {
                Navigator.pushNamed(context, 'Login Page');
              } else {
                Navigator.pushNamed(context, 'Profile Page', arguments: detay);
              }
            },
            icon: const Icon(
              Icons.account_circle_sharp,
              size: 29,
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(15),
          ),
        ],
      ),
      drawer: const DrawePage(),
      body: FutureBuilder(
        future: localDataRead(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  decoration: DecorationCreate2(),
                  height: 130,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.purple,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(38),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/gunluk_yorum_image/gunluk_yorum_buyuk/${Strings.BURC_ADLARI[index]}.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: animationGunlukYorum.value + 70,
                                height: animationGunlukYorum.value + 70,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => gunlukYorumPage(
                                      hangiBurc: Strings.BURC_ADLARI[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: 45,
                              left: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.purple,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(38),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/gunluk_yorum_image/gunluk_yorum_kucuk/${Strings.BURC_ADLARI[index]}.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 27,
                                height: 27,
                              ),
                            ),
                            Positioned(
                              top: 80,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.brown.shade500,
                                ),
                                child: Text(
                                  Strings.BURC_ADLARI[index],
                                  style: GoogleFonts.quicksand(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: animationGunlukYorumYazi.value,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  height: 7,
                  color: Colors.purple,
                  thickness: 7,
                ),
                Expanded(
                  child: Container(
                    decoration: DecorationCreate(),
                    child: Center(
                      child: ListView.builder(
                        itemCount: widget.tumBurclar.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: BurcItem(
                              listenenBurc: widget.tumBurclar[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
            );
          }
        },
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

  DecorationCreate2() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.pinkAccent, Colors.orangeAccent],
      ),
    );
  }
}
