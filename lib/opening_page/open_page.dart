import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        primary: false,
        padding: EdgeInsets.all(3),
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
            "assets/images/opening_image/yorum.jpg",
            'PageCreate2',
            'Yorum Page',
            text: 'YORUMLAR',
          ),
          /* create(
            context,
            "assets/images/opening_image/uyum.jpg",
            'Burc Uyumu',
            'Uyum Page',
          ), */
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

  GestureDetector create(
      BuildContext context, String image, String page, String toastText,
      {String text = ''}) {
    List? bilgiler = null;

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange,
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
            color: Colors.orange,
            width: 3,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.yellow,
              offset: Offset(5, 5),
              blurRadius: 20,
            ),
          ],
        ),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      onTap: () {
        if (page == 'EXİT') {
          exit(0);
        } /* else if (page == 'PageCreate2') {
          var secilen;
          List<String> burcAd = Strings.BURC_ADLARI;
          ControlCreate(
            context,
            burcAd,
            secilen,
            "Burç Yorumunu Getir",
            page,
            (data) {
              secilen = data;
            },
            (String? veri) {
              secilen = veri!;
            },
          );
        }  */
        else {
          bilgiler?[0] = '0';
          Navigator.pushNamed(context, page, arguments: bilgiler);
        }
      },
      onDoubleTap: () {
        if (page == 'EXİT') {
          exit(0);
        }
        Navigator.pushNamed(context, page, arguments: bilgiler);
      },
      onLongPress: () {
        EasyLoading.showToast(
          toastText,
          duration: Duration(
            seconds: 3,
          ),
          toastPosition: EasyLoadingToastPosition.center,
        );
      },
    );
  }

/*   Future<dynamic> ControlCreate(
    BuildContext context,
    List<String> burcAd,
    secilen,
    String text,
    String page,
    void Function(String?)? onSaved,
    void Function(String?)? onChanged,
  ) {
    secilen = Strings.BURC_ADLARI[0];
    return showDialog(
      barrierColor: Colors.orange,
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          "Burç Seçiniz ",
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: DropdownButtonFormField(
          value: Strings.BURC_ADLARI[0],
          autofocus: true,
          dropdownColor: Colors.orange,
          iconSize: 27,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(
            Icons.details,
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          hint: Text(
            'Burç Seçiniz',
            style: TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          items: burcAd
              .map(
                (String e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          onSaved: onSaved,
          onChanged: onChanged,
        ),
        actions: <Widget>[
          Center(
              child: Column(
            children: [
              ElevatedButton.icon(
                label: Text(text),
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    page,
                    arguments: secilen,
                  );
                },
              ),
              ElevatedButton.icon(
                label: Text("GERİ DÖN"),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ))
        ],
      ),
    );
  } */
}
