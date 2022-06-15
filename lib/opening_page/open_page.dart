// ignore_for_file: non_constant_identifier_names, avoid_init_to_null

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
// Uygulamada kullanılmıyor hoşuma gitmediği için kaldırdım.
class OpeningPage extends StatelessWidget {
  const OpeningPage({Key? key}) : super(key: key);

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      color: colorss,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationCreate(),
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        primary: false,
        padding: const EdgeInsets.all(3),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [
          create(
            context,
            "assets/images/opening_image/burccemberi.jpg",
            'Burc Listesi',
            'Home Page',
            text: 'ANA SAYFA',
          ),
          create(
            context,
            "assets/images/opening_image/login.jpg",
            'Login Page',
            'Login Page',
          ),
          create(
            context,
            "assets/images/opening_image/signUp.jpg",
            'Sign Up Page',
            'Sign Up Page',
          ),
          create(
            context,
            "assets/images/opening_image/profile.jpg",
            'Login Page',
            'Profile Page',
          ),
          create(
            context,
            "assets/images/opening_image/grup.jpg",
            'Burc Grubu',
            'Grup Page',
            text: 'GRUPLAR',
          ),
          create(
            context,
            "assets/images/opening_image/diyet.jpg",
            'Burc Diyeti',
            'Diyeti Page',
            text: 'DİYETLER',
          ),
          create(
            context,
            "assets/images/opening_image/mitoloji.jpg",
            'Mitoloji',
            'Burc Mitoloji',
            text: 'MİTOLOJİ',
          ),
          create(
            context,
            "assets/images/opening_image/logout.jpg",
            'EXİT',
            'EXİT',
          ),
        ],
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

  GestureDetector create(
      BuildContext context, String image, String page, String toastText,
      {String text = ''}) {
    List? bilgiler = null;

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.blue,
              Colors.black,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(5, 5),
              blurRadius: 30,
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            text,
            style: style(22, Colors.white),
          ),
        ),
      ),
      onTap: () {
        if (page == 'EXİT') {
          exit(0);
        } else {
          bilgiler?[0] = '0';
          debugPrint(bilgiler.toString());
          Navigator.pushNamed(context, page, arguments: bilgiler);
        }
      },
      onDoubleTap: () {
        if (page == 'EXİT') {
          exit(0);
        } else {
          bilgiler?[0] = '0';
          Navigator.pushNamed(context, page, arguments: bilgiler);
        }
      },
      onLongPress: () {
        EasyLoading.showToast(
          toastText,
          duration: const Duration(
            seconds: 3,
          ),
          toastPosition: EasyLoadingToastPosition.center,
        );
      },
    );
  }
}
