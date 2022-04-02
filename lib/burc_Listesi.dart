import 'package:burc_rehberi/burc_items.dart';
import 'package:burc_rehberi/data/strings.dart';
import 'package:burc_rehberi/drawer_page/drawe_page.dart';
import 'package:burc_rehberi/modeller/burc.dart';
import 'package:flutter/material.dart';

class BurcListesi extends StatefulWidget {
  late List<Burc> tumBurclar = [];

  BurcListesi() {
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

class _BurcListesiState extends State<BurcListesi> {
  var kontol;
  List? kontrolDrawer;
  @override
  Widget build(BuildContext context) {
    kontol = ModalRoute.of(context)?.settings.arguments;
    print(kontol);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Burclar Listesi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (kontol == null || kontol?[0] == '0') {
                kontol = await Navigator.pushNamed(context, 'Login Page');
                kontrolDrawer = kontol;
              } else {
                kontol = await Navigator.pushNamed(context, 'Profile Page',
                    arguments: kontol);
              }
              setState(
                () {
                  kontrolDrawer = kontol;
                },
              );
            },
            icon: Icon(
              Icons.account_circle_sharp,
              size: 29,
              color: Colors.black,
            ),
            padding: EdgeInsets.all(15),
          ),
        ],
      ),
      drawer: DrawePage(bilgiler: kontol),
      body: Container(
        color: Colors.orange.shade900,
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
    );
  }
}
