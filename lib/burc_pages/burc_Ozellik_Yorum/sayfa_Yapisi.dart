// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:burc_rehberi/modeller/burc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PageCreate extends StatefulWidget {
  final SecilenBurc;
  const PageCreate({required Burc this.SecilenBurc, Key? key})
      : super(key: key);

  @override
  State<PageCreate> createState() => _PageCreateState();
}

class _PageCreateState extends State<PageCreate>
    with SingleTickerProviderStateMixin {
  late PaletteGenerator _generator;
  Color appBarColor = Colors.transparent;
  Color bodyColor = Colors.white;

  late AnimationController controller;
  late Animation animationButton;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => appBarRengi());

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.addListener(() {
      setState(() {});
    });
    animationButton = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    controller.forward();
    controller.addStatusListener((durum) {
      if (durum == AnimationStatus.completed) {
        controller.reverse().orCancel;
      } else if (durum == AnimationStatus.dismissed) {
        controller.forward().orCancel;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: DecorationCreate(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
              expandedHeight: 250,
              pinned: true,
              backgroundColor: appBarColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.SecilenBurc.burcAdi + " Burcu ve Özellikleri",
                  style: style(18, Colors.yellowAccent),
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
                      shape: const StadiumBorder(),
                      elevation: 20,
                      shadowColor: Colors.black,
                      side: BorderSide(
                        width: 3,
                        style: BorderStyle.solid,
                        color: animationButton.value,
                      ),
                    ),
                    onLongPress: () {
                      EasyLoading.showToast(
                          widget.SecilenBurc.burcAdi +
                              ' Burcuyla Alakalı Yorumlar',
                          duration: const Duration(seconds: 3),
                          toastPosition: EasyLoadingToastPosition.center);
                    },
                    onPressed: () {
                      Navigator.pushNamed(context, 'PageCreate2',
                          arguments: widget.SecilenBurc.burcAdi);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: Text(
                      'Burç Yorumları İçin Tıkla',
                      style: style(20, Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 20,
                      color: Colors.transparent,
                      child: ListTile(
                        title: Container(
                          // padding: EdgeInsets.all(4),
                          margin: const EdgeInsets.all(16),
                          child: Text(
                            widget.SecilenBurc.burcDetay,
                            style: style(22, Colors.white),
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
      ),
    );
  }
}
