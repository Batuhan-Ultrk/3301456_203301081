import 'dart:io';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final List bilgiler;
  ProfilPage({required this.bilgiler, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List basliklar = [
      'Username',
      'E Mail',
      'Phone Number',
      'Cinsiyet',
      'Burç',
      'About Me',
      'Password',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Uygulamadan Çık',
            onPressed: () {
              exit(0);
            },
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
              size: 27,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 28,
          ),
          tooltip: 'Ana Sayfaya Dön',
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'Burc Listesi',
                arguments: bilgiler);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: bilgiler.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 12,
            child: Column(
              children: [
                ListTile(
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.verified_user_sharp,
                        color: Colors.orange,
                        size: 30,
                      ),
                      Expanded(
                        child: Text(
                          basliklar[index],
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.blue,
                  height: 15,
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          bilgiler[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.turned_in_sharp,
                        color: Colors.green,
                        size: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
