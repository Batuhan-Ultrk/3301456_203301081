import 'package:burc_rehberi/data/burc_diyet_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DiyetPage extends StatelessWidget {
  const DiyetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burç Diyetleri'),
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
      ),
      body: ListView.builder(
        itemCount: BurcDiyet.BURC_DIYET_BASLIK.length,
        itemBuilder: (BuildContext context, int index) {
          List<String> baslikdetay = [
            BurcDiyet.BURC_DIYET_BASLIK[index],
            BurcDiyet.BURC_DIYET_DETAY[index],
            BurcDiyet.BURC_ADLARI[index],
          ];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onLongPress: () {
                    EasyLoading.showToast(
                      BurcDiyet.BURC_DIYET_BASLIK[index],
                      duration: Duration(seconds: 3),
                      toastPosition: EasyLoadingToastPosition.center,
                    );
                  },
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'BurcDiyetCreate',
                      arguments: baslikdetay,
                    );
                  },
                  label: Text(
                    BurcDiyet.BURC_DIYET_BASLIK[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  icon: Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: StadiumBorder(),
                    elevation: 17,
                    fixedSize: Size(400, 50),
                    shadowColor: Colors.grey,
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
