import 'package:burc_rehberi/data/burc_uyum_detay.dart';
import 'package:flutter/material.dart';

class BurcUyumCreate extends StatelessWidget {
  final index;
  const BurcUyumCreate({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BurcUyum.UYUM_AD[index],
        ),
      ),
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Create(
                index,
                'UYUM YÜZDESİ',
                BurcUyum.UYUM_YUZDE[index],
              ),
              Create(
                index,
                'BURÇLARIN UYUM YORUMU',
                BurcUyum.UYUM_DETAY[index],
              ),
              Create(
                index,
                'UYUM YÜZDESİ YORUMU',
                BurcUyum.UYUM_YUZDE_DETAY[index],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Create(index, String textTitle, String text) {
    return ExpansionTile(
      backgroundColor: Colors.orange,
      title: Text(
        textTitle,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      leading: IconCreate(
        Icons.notes_rounded,
      ),
      trailing: IconCreate(
        Icons.format_line_spacing_rounded,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Icon IconCreate(IconData icons) {
    return Icon(
      icons,
      size: 35,
      color: Colors.yellow,
    );
  }
}
