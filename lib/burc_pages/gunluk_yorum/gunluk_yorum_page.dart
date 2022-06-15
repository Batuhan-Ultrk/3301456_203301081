// ignore_for_file: camel_case_types, must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;


class gunlukYorumPage extends StatefulWidget {
  var hangiBurc;
  gunlukYorumPage({this.hangiBurc, Key? key}) : super(key: key);

  @override
  State<gunlukYorumPage> createState() => _gunlukYorumPageState();
}

class _gunlukYorumPageState extends State<gunlukYorumPage> {
  List Data = [];
  List Date = [];
  var url;
  var response;
  var Gelendate;
  var Gelendata;
  int indexs = 0;
  String burc = '';

  Future getData() async {
    switch (widget.hangiBurc) {
      case 'Koc':
        url = Uri.parse('https://www.elle.com.tr/astroloji/koc');
        break;
      case 'Boga':
        url = Uri.parse('https://www.elle.com.tr/astroloji/boga');
        break;
      case 'Ikizler':
        url = Uri.parse('https://www.elle.com.tr/astroloji/ikizler');
        break;
      case 'Yengec':
        url = Uri.parse('https://www.elle.com.tr/astroloji/yengec');
        break;
      case 'Aslan':
        url = Uri.parse('https://www.elle.com.tr/astroloji/aslan');
        break;
      case 'Basak':
        url = Uri.parse('https://www.elle.com.tr/astroloji/basak');
        break;
      case 'Terazi':
        url = Uri.parse('https://www.elle.com.tr/astroloji/terazi');
        break;
      case 'Akrep':
        url = Uri.parse('https://www.elle.com.tr/astroloji/akrep');
        break;
      case 'Yay':
        url = Uri.parse('https://www.elle.com.tr/astroloji/yay');
        break;
      case 'Oglak':
        url = Uri.parse('https://www.elle.com.tr/astroloji/oglak');
        break;
      case 'Kova':
        url = Uri.parse('https://www.elle.com.tr/astroloji/kova');
        break;
      case 'Balik':
        url = Uri.parse('https://www.elle.com.tr/astroloji/balik');
        break;
      default:
    }

    try {
      var res = await http.get(url);
      final body = res.body;
      final document = parser.parse(body);
      Gelendate = document
          .getElementsByClassName('standard-article-body--text')[0]
          .getElementsByTagName('strong');

      Gelendata = document
          .getElementsByClassName('standard-article-body--text')[0]
          .getElementsByTagName('div');

      for (var item in Gelendata) {
        Data.add(item.text.toString());
      }
      for (var item in Gelendate) {
        Date.add(item.text.toString());
      }
      List<List> tumList = [Date, Data];
      return tumList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        bottomOpacity: 55,
        elevation: 10,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/gunluk_yorum_image/gunluk_yorum_kucuk/${widget.hangiBurc}.jpg",
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var liste = snapshot.data!;
            var dates = liste[0];
            var datas = liste[1];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      padEnds: true,
                      pageSnapping: true,
                      onPageChanged: (index) {
                        setState(
                          () {
                            indexs = index;
                          },
                        );
                      },
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: DecorationCreate(),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    "${dates[index]}\n${widget.hangiBurc} Burcu Günlük Burç Yorumu",
                                    textAlign: TextAlign.center,
                                    style: style(35, Colors.yellow),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 204,
                              left: 272,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(38),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/gunluk_yorum_image/gunluk_yorum_buyuk/${widget.hangiBurc}.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 12,
                    thickness: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_right_sharp,
                        size: 30,
                        color: Colors.purple,
                      ),
                      Text(
                        'Geçmiş Tarihli Burç Yorumları için Sağa Kaydırın',
                        style: style(12, Colors.black),
                      ),
                      const Icon(
                        Icons.arrow_right_sharp,
                        size: 30,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 12,
                    thickness: 5,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          decoration: DecorationCreate(),
                          width: double.infinity,
                          height: 400,
                          child: ListTile(
                            title: Text(
                              datas[indexs],
                              textAlign: TextAlign.center,
                              style: style(20, Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  BoxDecoration DecorationCreate() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 5,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(35),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Colors.purple, Colors.orangeAccent],
      ),
    );
  }
}
