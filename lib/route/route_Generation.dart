// ignore_for_file: file_names, non_constant_identifier_names

import 'package:burc_rehberi/burc_pages/burc_Diyet/burc_Diyet.dart';
import 'package:burc_rehberi/burc_pages/burc_Diyet/burc_Diyet_Create.dart';
import 'package:burc_rehberi/burc_pages/burc_Uyum/burc_Uyum.dart';
import 'package:burc_rehberi/burc_pages/burc_Ozellik_Yorum/sayfa_Yapisi.dart';
import 'package:burc_rehberi/burc_pages/burc_Ozellik_Yorum/sayfa_Yapisi2.dart';
import 'package:burc_rehberi/burc_pages/gunluk_yorum/gunluk_yorum_page.dart';
import 'package:burc_rehberi/burc_pages/mitoloji_page/mitoloji_page.dart';
import 'package:burc_rehberi/drawer_page/drawe_page.dart';
import 'package:burc_rehberi/login_page/giris_sayfa.dart';
import 'package:burc_rehberi/main.dart';
import 'package:burc_rehberi/modeller/burc.dart';
import 'package:burc_rehberi/profile_page/profil_sayfa.dart';
import 'package:burc_rehberi/sign_up_page/uye_kayit_sayfa.dart';
import 'package:burc_rehberi/to_do_page/to_do_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../burc_Listesi.dart';
import '../burc_pages/burc_Grup/burc_Grup.dart';
import '../burc_pages/burc_Uyum/burc_Uyum_Create.dart';

class RouteGenerations {
  static Route<dynamic>? RouteGeneration(RouteSettings settings) {
    switch (settings.name) {
      case 'PageCreate2':
        return _control(
          settings,
          PageCreate2(burc: settings.arguments as String),
        );

      case 'PageCreate':
        return _control(
          settings,
          PageCreate(SecilenBurc: settings.arguments as Burc),
        );

      case 'Login Page':
        return _control(
          settings,
          const LoginPage(),
        );
      case 'Sign Up Page':
        return _control(
          settings,
          const SignUpPage(),
        );

      case 'Opening Page':
        return _control(
          settings,
          const Anasayfa(),
        );

      case 'Profile Page':
        return _control(
          settings,
          ProfilPage(bilgiler: settings.arguments as List),
        );

      case 'Burc Uyumu':
        return _control(
          settings,
          UyumPage(),
        );

      case 'BurcUyumCreate':
        return _control(
          settings,
          BurcUyumCreate(index: settings.arguments),
        );

      case 'Burc Grubu':
        return _control(
          settings,
          const GrupPage(),
        );

      case 'Burc Diyeti':
        return _control(
          settings,
          const DiyetPage(),
        );

      case 'BurcDiyetCreate':
        return _control(
          settings,
          BurcDiyetCreate(
            baslikDetayAd: settings.arguments as List<String>,
          ),
        );

      case 'Burc Listesi':
        return _control(
          settings,
          BurcListesi(),
        );

      case 'Drawer':
        return _control(
          settings,
          const DrawePage(),
        );

      case 'GunlukYorum':
        return _control(
          settings,
          gunlukYorumPage(),
        );

      case 'Mitoloji':
        return _control(
          settings,
          const MitolojiPage(),
        );

      case 'Yapilacaklar':
        return _control(
          settings,
          ToDoPage(username: settings.arguments as String),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Center(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'ERROR',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  'SAYFA BULUNAMADI',
                  style: TextStyle(color: Colors.black, fontSize: 50),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
    }
  }

  static dynamic _control(RouteSettings settings, Widget page) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => page,
    );
  }
}
