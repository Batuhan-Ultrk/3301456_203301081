// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:burc_rehberi/data/burc_uyum_detay.dart';
import 'package:burc_rehberi/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class UyumPage extends StatefulWidget {
  List<String> burcAd = Strings.BURC_ADLARI;
  UyumPage({Key? key}) : super(key: key);

  @override
  State<UyumPage> createState() => _UyumPageState();
}

class _UyumPageState extends State<UyumPage> {
  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  String burcKadin = '', burcErkek = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Burç Uyum",
            style: style(21, Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 27,
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
          decoration: DecorationCreate(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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
                const SizedBox(
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
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onLongPress: () {
                      EasyLoading.showToast(
                        'Burç Uyumu Hesapla',
                        duration: const Duration(seconds: 3),
                        toastPosition: EasyLoadingToastPosition.center,
                      );
                    },
                    onPressed: () {
                      bool _validate = _formKey.currentState!.validate();
                      if (_validate) {
                        _formKey.currentState?.save();
                        int? index;
                        for (var i = 0; i < BurcUyum.UYUM_AD.length; i++) {
                          if (BurcUyum.UYUM_AD[i] ==
                              "KADIN ${burcKadin.toUpperCase()} - ERKEK ${burcErkek.toUpperCase()}") {
                            index = i;
                          } else {
                            debugPrint("olmadı");
                          }
                        }
                        debugPrint(index.toString());
                        Navigator.pushNamed(
                          context,
                          'BurcUyumCreate',
                          arguments: index,
                        );
                      }
                    },
                    label: Text(
                      'Burç Uyumu Hesapla',
                      style: style(20, Colors.white),
                    ),
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 17,
                      shadowColor: Colors.grey,
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: BurcUyum.UYUM_GENEL_BASLIK.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 12,
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    Icons.drag_indicator_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  Expanded(
                                    child: Text(
                                      BurcUyum.UYUM_GENEL_BASLIK[index],
                                      style: style(15, Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DivideCreate(),
                            ListTile(
                              tileColor: Colors.transparent,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      BurcUyum.UYUM_GENEL[index],
                                      style: style(14, Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider DivideCreate() {
    return const Divider(
      color: Colors.orange,
      indent: 15,
      endIndent: 20,
      height: 15,
      thickness: 10,
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
        errorStyle: style(13, Colors.orange),
      ),
      icon: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      style: style(18, Colors.black),
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
        style: style(17, Colors.blueGrey),
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
