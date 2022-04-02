import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DrawePage extends StatelessWidget {
  var bilgiler;
  DrawePage({required this.bilgiler, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(bilgiler);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, bilgiler);
        print(bilgiler);
      },
      child: Drawer(
        backgroundColor: Colors.yellow.shade100,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Divider(
                    color: Colors.blue,
                    height: 10,
                  ),
                  RowCreateStars(),
                  RowCreate('BURÇ REHBERİ', 25),
                  RowCreate('Burçlarla İlgili Her Şey', 15),
                  RowCreateStars(),
                  Divider(
                    color: Colors.blue,
                    height: 10,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.orange.shade600,
                child: ExpansionTile(
                  title: Text(
                    'BURÇLARLA İLGİLİ DAHA FAZLASI',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
            CreateCard(context, Icons.exit_to_app_rounded, 'GÜVENLİ ÇIKIŞ',
                'Safe Exit'),
          ],
        ),
      ),
    );
  }

  Icon IconCreate() {
    return Icon(
      Icons.arrow_drop_down_circle_outlined,
      size: 25,
      color: Colors.yellow.shade200,
    );
  }

  Row RowCreate(String text, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // padding: EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: size,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Row RowCreateStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StarsIkons(),
        StarsIkons(),
      ],
    );
  }

  Icon StarsIkons() {
    return Icon(
      Icons.star_border_purple500_sharp,
      size: 35,
      color: Colors.yellow,
    );
  }

  Card CreateCard(context, IconData shape, String page, String LongText) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 15,
      color: Colors.orange,
      child: ListTile(
        onLongPress: () {
          EasyLoading.showToast(
            LongText,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.center,
          );
        },
        onTap: () async {
          if ((bilgiler == null || bilgiler![0] == '0') &&
              (page == 'GİRİŞ' || page == 'PROFİL')) {
            bilgiler = await Navigator.pushNamed(context, 'Login Page') as List;

            //  Navigator.pushNamed(context, 'Login Page', arguments: bilgiler);
          } else if (page == 'PROFİL') {
            Navigator.pushNamed(context, 'Profile Page', arguments: bilgiler);
          } else if (page == 'GİRİŞ') {
            UyariAlertDialogCreate(
              context,
            );
          } else if (page == 'GÜVENLİ ÇIKIŞ') {
            exit(0);
          } else {
            Navigator.pushReplacementNamed(context, LongText);
          }
        },
        leading: Icon(
          shape,
          size: 25,
          color: Colors.yellow.shade200,
        ),
        title: Text(
          page,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void UyariAlertDialogCreate(context) {
    showDialog(
      barrierColor: Colors.orange.shade900,
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          "UYARI!",
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Giriş bilgileriniz bulunmaktadır. Tekrar giriş yapmak için uygulamadan çıkış yapınız...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          Center(
              child: Column(
            children: [
              ElevatedButton.icon(
                label: Text("UYGULAMADAN ÇIK"),
                icon: Icon(
                  Icons.exit_to_app_rounded,
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              ElevatedButton.icon(
                label: Text("PROFİLE GİT"),
                icon: Icon(
                  Icons.account_circle_sharp,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    'Profile Page',
                    arguments: bilgiler,
                  );
                },
              ),
              ElevatedButton.icon(
                label: Text("GERİ DÖN"),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
                onPressed: () {
                  var kontrol;
                  Navigator.pop(
                    context,
                    kontrol,
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
