import 'package:burc_rehberi/modeller/burc.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PageCreate extends StatefulWidget {
  final SecilenBurc;
  PageCreate({required Burc this.SecilenBurc, Key? key}) : super(key: key);

  @override
  State<PageCreate> createState() => _PageCreateState();
}

class _PageCreateState extends State<PageCreate> {
  late PaletteGenerator _generator;
  Color appBarColor = Colors.transparent;
  Color bodyColor = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => appBarRengi());
  }

  Future<void> appBarRengi() async {
    _generator = await PaletteGenerator.fromImageProvider(
      AssetImage('assets/images/${widget.SecilenBurc.buyukResim}'),
    );

    setState(
      () {
        appBarColor = _generator.dominantColor!.color;
        bodyColor = _generator.vibrantColor!.color;
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
            expandedHeight: 250,
            pinned: true,
            backgroundColor: appBarColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.SecilenBurc.burcAdi + " Burcu ve Özellikleri",
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              background: Image.asset(
                "assets/images/" + widget.SecilenBurc.buyukResim,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: bodyColor,
                    shape: StadiumBorder(),
                    elevation: 20,
                    //  fixedSize: Size(130, 50),
                    shadowColor: Colors.grey,
                    side: BorderSide(
                      width: 3,
                      style: BorderStyle.solid,
                      color: Colors.black,
                    ),
                  ),
                  onLongPress: () {
                    EasyLoading.showToast(
                        widget.SecilenBurc.burcAdi +
                            ' Burcuyla Alakalı Yorumlar',
                        duration: Duration(seconds: 3),
                        toastPosition: EasyLoadingToastPosition.center);
                  },
                  onPressed: () {
                    Navigator.pushNamed(context, 'PageCreate2',
                        arguments: widget.SecilenBurc.burcAdi);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  label: Text(
                    'Burç Yorumları İçin Tıkla',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 20,
                    color: bodyColor,
                    child: ListTile(
                      title: Container(
                        // padding: EdgeInsets.all(4),
                        margin: EdgeInsets.all(16),
                        child: Text(
                          widget.SecilenBurc.burcDetay,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
