import 'package:burc_rehberi/data/burc_uyum_detay.dart';
import 'package:burc_rehberi/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UyumPage extends StatefulWidget {
  List<String> burcAd = Strings.BURC_ADLARI;
  UyumPage({Key? key}) : super(key: key);

  @override
  State<UyumPage> createState() => _UyumPageState();
}

class _UyumPageState extends State<UyumPage> {
  String burcKadin = '', burcErkek = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int kontrol = 0;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Burç Uyum"),
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
        body: Container(
          color: Colors.yellow.shade500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DropDownButtonCreate(
                  burcKadin,
                  'Kadın Burcu',
                  (data2) {
                    setState(
                      () {
                        burcKadin = data2!;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                DropDownButtonCreate(
                  burcErkek,
                  'Erkek Burcu',
                  (data2) {
                    setState(
                      () {
                        burcErkek = data2!;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton.icon(
                  onLongPress: () {
                    EasyLoading.showToast(
                      'Burç Uyumu Hesapla',
                      duration: Duration(seconds: 3),
                      toastPosition: EasyLoadingToastPosition.center,
                    );
                  },
                  onPressed: () {
                    bool _validate = _formKey.currentState!.validate();
                    if (_validate) {
                      _formKey.currentState?.save();
                      List<String> gonderme = [burcKadin, burcErkek];
                      int? index;
                      for (var i = 0; i < BurcUyum.UYUM_AD.length; i++) {
                        if (BurcUyum.UYUM_AD[i] ==
                            "KADIN ${burcKadin.toUpperCase()} - ERKEK ${burcErkek.toUpperCase()}") {
                          index = i;
                        } else {
                          print("olmadı");
                        }
                      }
                      print(index);
                      Navigator.pushNamed(
                        context,
                        'BurcUyumCreate',
                        arguments: index,
                      );
                    }
                  },
                  label: Text(
                    'Burç Uyumu Hesapla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    elevation: 17,
                    shadowColor: Colors.grey,
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> DropDownButtonCreate(
      String save, String text, void Function(String?)? onSaved) {
    return DropdownButtonFormField(
      validator: ((value) {
        if (value == null) {
          return 'Burç Seçiniz.';
        }
      }),
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
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      items: widget.burcAd
          .map(
            (String e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ),
          )
          .toList(),
      onChanged: (String? data) {
        setState(
          () {
            save = data!;
          },
        );
      },
      onSaved: onSaved,
      hint: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
