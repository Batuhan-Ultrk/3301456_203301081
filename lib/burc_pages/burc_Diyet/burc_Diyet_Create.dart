// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BurcDiyetCreate extends StatelessWidget {
  final List baslikDetayAd;
  const BurcDiyetCreate({required List<String> this.baslikDetayAd, Key? key})
      : super(key: key);

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
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              'Burc Listesi',
            );
          },
        ),
        title: Text(
          baslikDetayAd[0],
          style: style(21, Colors.black),
        ),
      ),
      body: Container(
        color: Colors.orange,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SizedBox(
              height: 219,
              child: Image.asset(
                'assets/images/diyet_image/${baslikDetayAd[2]}.jpg',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              builder: (context, scrollController) {
                return Container(
                  decoration: DecorationCreate(),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          baslikDetayAd[1],
                          style: style(17, Colors.white),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
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
}
