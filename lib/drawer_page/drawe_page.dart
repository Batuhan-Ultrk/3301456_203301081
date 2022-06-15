// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawePage extends StatefulWidget {
  const DrawePage({Key? key}) : super(key: key);

  @override
  State<DrawePage> createState() => _DrawePageState();
}

class _DrawePageState extends State<DrawePage>
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
  final List basliklar = [
    'E Mail',
    'Username',
    'Phone Number',
    'Gender',
    'Date Of Birth',
    'Age',
    'Burç',
    'About Me',
    'date of registration',
  ];
  String userNameBaslik = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  late Animation animationDrawer;
  late AnimationController controller;

  @override
  void initState() {
    localDataRead();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    controller.addStatusListener((durum) {
      if (durum == AnimationStatus.completed) {
        controller.reverse().orCancel;
      } else if (durum == AnimationStatus.dismissed) {
        controller.forward().orCancel;
      }
    });

    animationDrawer = ColorTween(begin: Colors.white, end: Colors.cyan.shade200)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Divider(
                    color: animationDrawer.value,
                    height: 28,
                    indent: 130,
                    thickness: 8,
                  ),
                  RowCreate('BURÇ REHBERİ', 25),
                  RowCreate('Burçlarla İlgili Her Şey', 20),
                  Divider(
                    color: animationDrawer.value,
                    height: 28,
                    indent: 8,
                    endIndent: 130,
                    thickness: 8,
                  ),
                  RowCreate(userNameBaslik, 15),
                ],
              ),
              decoration: DecorationCreate(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: DecorationCreate(),
                child: ExpansionTile(
                  title: Text(
                    'BURÇLARLA İLGİLİ DAHA FAZLASI',
                    style: style(17, Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  leading: IconCreate(),
                  trailing: IconCreate(),
                  children: [
                    CreateCard(context, Icons.category_outlined, 'BURÇ UYUMU',
                        'Burc Uyumu'),
                    CreateCard(context, Icons.category_outlined, 'BURÇ GRUBU',
                        'Burc Grubu'),
                    CreateCard(context, Icons.category_outlined, 'BURÇ DİYETİ',
                        'Burc Diyeti'),
                    CreateCard(context, Icons.category_outlined, 'MİTOLOJİ',
                        'Mitoloji'),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            CreateCard(
                context, Icons.home_rounded, 'AÇILIŞ SAYFASI', 'Opening Page'),
            CreateCard(
                context, Icons.account_circle_sharp, 'GİRİŞ', 'Login Page'),
            CreateCard(
                context, Icons.account_box_rounded, 'PROFİL', 'Profile Page'),
            CreateCard(context, Icons.data_saver_on_rounded, 'KAYIT OL',
                'Sign Up Page'),
            CreateCard(context, Icons.delete, 'KAYIT SİL', 'Kayıt Delete'),
            CreateCard(context, Icons.exit_to_app_rounded, 'GÜVENLİ ÇIKIŞ',
                'Safe Exit'),
          ],
        ),
      ),
    );
  }

  BoxDecoration DecorationCreate() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Colors.purple, Colors.orangeAccent],
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.cyan,
          offset: Offset(-10, 5),
          blurRadius: 8.0,
          spreadRadius: 1.0,
        ), //BoxShadow
      ],
      borderRadius: BorderRadius.circular(70),
    );
  }

  Icon IconCreate() {
    return const Icon(
      Icons.arrow_drop_down_circle_outlined,
      size: 25,
      color: Colors.yellow,
    );
  }

  Row RowCreate(String text, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: style(size, Colors.white),
        ),
      ],
    );
  }

  Card CreateCard(context, IconData shape, String page, String LongText) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8),
      elevation: 15,
      color: Colors.cyan.withOpacity(0.8),
      child: ListTile(
        onLongPress: () {
          EasyLoading.showToast(
            LongText,
            duration: const Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.center,
          );
        },
        onTap: () async {
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

          if (page == 'PROFİL') {
            if (detay[0] == '') {
              Navigator.pushNamed(context, 'Login Page');
            } else {
              Navigator.pushNamed(context, 'Profile Page', arguments: detay);
            }
          } else if (page == 'GİRİŞ') {
            if (detay[0] == '') {
              Navigator.pushNamed(context, 'Login Page');
            } else {
              UyariAlertDialogCreate(
                context,
              );
            }
          } else if (page == 'GÜVENLİ ÇIKIŞ') {
            exit(0);
          } else if (page == 'KAYIT SİL') {
            if (auth.currentUser != null) {
              await auth.currentUser!.delete();
              localDataClearSave();
              firebaseDataDelete(detay);
              EasyLoading.showToast(
                'Kullanıcı Başarıyla Silinmiştir.',
                duration: const Duration(
                  seconds: 3,
                ),
                toastPosition: EasyLoadingToastPosition.center,
              );
            } else {
              EasyLoading.showToast(
                'Kullanıcı Girişi Yapmanız Gerekmektedir.',
                duration: const Duration(
                  seconds: 3,
                ),
                toastPosition: EasyLoadingToastPosition.center,
              );
            }
          } else {
            Navigator.pushReplacementNamed(context, LongText);
          }
        },
        leading: Icon(
          shape,
          size: 25,
          color: Colors.yellow,
        ),
        title: Text(
          page,
          style: style(17, Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  TextStyle style(double size, Color colors) {
    return GoogleFonts.quicksand(
        fontSize: size, fontWeight: FontWeight.w900, color: colors);
  }

  void UyariAlertDialogCreate(context) {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          "UYARI!",
          style: style(25, Colors.red),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Giriş bilgileriniz bulunmaktadır. Tekrar giriş yapmak için uygulamadan çıkış yapmanız gerekmetedir...',
          textAlign: TextAlign.center,
          style: style(20, Colors.black),
        ),
        actions: <Widget>[
          Center(
              child: Column(
            children: [
              ElevatedButton.icon(
                label: const Text("GERİ DÖN"),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ],
          ))
        ],
      ),
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
    if (_Username == "") {
      userNameBaslik = 'Lütfen Giriş Yapınız...';
    } else {
      userNameBaslik = 'Hoşgeldin $_Username';
    }
    setState(() {});
  }

  localDataClearSave() async {
    var preferences = const FlutterSecureStorage();

    for (var i = 0; i < basliklar.length; i++) {
      await preferences.write(key: basliklar[i], value: '');
    }
  }

  Future<void> firebaseDataDelete(List<String> detay) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.doc('users/${detay[0]}').delete();
  }
}
