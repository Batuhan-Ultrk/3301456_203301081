import 'package:burc_rehberi/data/burc_grup_detay.dart';
import 'package:flutter/material.dart';

class GrupPage extends StatelessWidget {
  const GrupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
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
          'Burç Grupları',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        color: Colors.greenAccent,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: BurcGrup.BURC_GRUPLARI.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.yellow.shade700,
                elevation: 20,
                child: Column(
                  children: [
                    ListTile(
                      tileColor: Colors.red,
                      leading: Icon(
                        Icons.notes_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                      title: Text(
                        BurcGrup.BURC_GRUPLARI[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          TextCreate(
                            index,
                            BurcGrup.BURC_GRUPLARI_UYELERI,
                          ),
                          Divider(
                            color: Colors.red,
                            height: 20,
                          ),
                          TextCreate(
                            index,
                            BurcGrup.BURC_GRUPLARI_DETAY,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Icon IconCreate() {
    return Icon(
      Icons.arrow_drop_down_circle_outlined,
      size: 25,
      color: Colors.black,
    );
  }

  Widget TextCreate(int index, List<String> BURC) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        BURC[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
