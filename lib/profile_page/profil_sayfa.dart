// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/local_Database.dart';
import '../main.dart';
import '../modeller/to_do_model.dart';

// ignore: must_be_immutable
class ProfilPage extends StatefulWidget {
  List bilgiler;
  ProfilPage({required this.bilgiler, Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animationWhiteBlack;
  late Animation animation2BlackWhite;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.addListener(() {
      setState(() {});
    });
    animationWhiteBlack = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));
    animation2BlackWhite = ColorTween(begin: Colors.black, end: Colors.white)
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

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LocalDatabase _localDatabase = locator<LocalDatabase>();
  List<Task> _allTasks = <Task>[];
  late String gonderilecekUsername;
  var _userDocument;
  late String _EMail,
      _Username,
      _PhoneNumber,
      _Gender,
      _DateOfBirth,
      _Age,
      _Burc,
      _AboutMe,
      _dateofregistration;

  final List basliklar = [
    'E Mail',
    'Username',
    'Phone Number',
    'Gender',
    'Date Of Birth',
    'Age',
    'Burç',
    'About Me',
    'date of registration',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: style(
            25,
            Colors.white,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Yapılacaklar Listesi',
            onPressed: () {
              Navigator.pushNamed(context, 'Yapilacaklar',
                  arguments: gonderilecekUsername);
            },
            icon: Icon(
              Icons.toc_rounded,
              color: _allTasks.isNotEmpty
                  ? animationWhiteBlack.value
                  : Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          IconButton(
            tooltip: 'Oturumu Kapat',
            onPressed: () {
              UyariAlertDialogCreate(context);
            },
            icon: const Icon(
              Icons.no_accounts_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 13,
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 28,
          ),
          tooltip: 'Ana Sayfaya Dön',
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              'Burc Listesi',
            );
          },
        ),
        elevation: 5,
      ),
      body: Container(
        decoration: DecorationCreate(),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: dataOku(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Map mapBilgiler = snapshot.data;

                    return ListView.builder(
                      itemCount: basliklar.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.transparent.withOpacity(0),
                          elevation: 12,
                          child: Column(
                            children: [
                              ListTile(
                                subtitle: Row(
                                  children: [
                                    const Icon(
                                      Icons.verified_user_sharp,
                                      color: Colors.lightBlue,
                                      size: 30,
                                    ),
                                    Expanded(
                                      child: Text(
                                        basliklar[index],
                                        style: style(
                                          18,
                                          Colors.yellowAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 10,
                                endIndent: 22,
                                indent: 22,
                                color: Colors.cyan,
                                height: 15,
                              ),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.5),
                                        child: Text(
                                          mapBilgiler[basliklar[index]],
                                          style: style(20, Colors.white),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.turned_in_sharp,
                                      color: Colors.greenAccent,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonCreate(
                  context,
                  'Yapılacaklar Listesi',
                  Icons.toc_rounded,
                  'To Do',
                  310,
                  20,
                ),
              ],
            )
          ],
        ),
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

  Widget ButtonCreate(BuildContext context, String toast, IconData? icon,
      String text, double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onLongPress: () {
          EasyLoading.showToast(
            toast,
            duration: const Duration(
              seconds: 3,
            ),
            toastPosition: EasyLoadingToastPosition.center,
          );
        },
        onPressed: () {
          Navigator.pushNamed(context, 'Yapilacaklar',
              arguments: gonderilecekUsername);
        },
        icon: Icon(
          icon,
          color:
              _allTasks.isNotEmpty ? animation2BlackWhite.value : Colors.white,
          size: 25,
        ),
        label: Text(
          text,
          style: style(
            17,
            _allTasks.isNotEmpty ? animation2BlackWhite.value : Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 25,
          fixedSize: Size(width, height),
          shadowColor: Colors.white,
          side: BorderSide(
            style: BorderStyle.solid,
            color:
                _allTasks.isNotEmpty ? animationWhiteBlack.value : Colors.white,
            width: 2,
          ),
        ),
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

  Future<Object> dataOku() async {
    if (widget.bilgiler[1] == '0') {
      _userDocument = await firestore.collection('users').get();
      widget.bilgiler[1] = '';
      for (var element in _userDocument.docs) {
        if (element.id == widget.bilgiler[0]) {
          Map userData = element.data();
          gonderilecekUsername = userData[basliklar[1]];
          toDoDatabaseVeriCek();
          localDataSave(userData);
          return userData;
        }
      }
      return {};
    } else {
      late Map toMap;
      List detay = [];
      var preferences = const FlutterSecureStorage();
      _EMail = await preferences.read(key: 'E Mail') ?? "";
      _Username = await preferences.read(key: 'Username') ?? "";
      _PhoneNumber = await preferences.read(key: 'Phone Number') ?? "";
      _Gender = await preferences.read(key: 'Gender') ?? "";
      _DateOfBirth = await preferences.read(key: 'Date Of Birth') ?? "";
      _Age = await preferences.read(key: 'Age') ?? "";
      _Burc = await preferences.read(key: 'Burç') ?? "";
      _AboutMe = await preferences.read(key: 'About Me') ?? "";
      _dateofregistration =
          await preferences.read(key: 'date of registration') ?? "";
      detay = [
        _EMail,
        _Username,
        _PhoneNumber,
        _Gender,
        _DateOfBirth,
        _Age,
        _Burc,
        _AboutMe,
        _dateofregistration
      ];

      toMap = {
        basliklar[0]: detay[0],
        basliklar[1]: detay[1],
        basliklar[2]: detay[2],
        basliklar[3]: detay[3],
        basliklar[4]: detay[4],
        basliklar[5]: detay[5],
        basliklar[6]: detay[6],
        basliklar[7]: detay[7],
        basliklar[8]: detay[8],
      };
      gonderilecekUsername = toMap[basliklar[1]];
      debugPrint('Local' + detay.toString());
      toDoDatabaseVeriCek();
      return toMap;
    }
  }

  localDataSave(Map mapBilgiler) async {
    var preferences = const FlutterSecureStorage();
    for (var i = 0; i < basliklar.length; i++) {
      await preferences.write(
          key: basliklar[i], value: mapBilgiler[basliklar[i]]);
    }
  }

  localDataClearSave() async {
    var preferences = const FlutterSecureStorage();

    for (var i = 0; i < basliklar.length; i++) {
      await preferences.write(key: basliklar[i], value: '');
    }
  }

  Future<void> signOutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<void> toDoDelete() async {
    for (var element in _allTasks) {
      _localDatabase.deleteTask(task: element);
    }
  }

  void UyariAlertDialogCreate(context) {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          "UYARI!",
          textAlign: TextAlign.center,
          style: style(25, Colors.red),
        ),
        content: Text(
          'Hesabınızdan Çıkış Yapılacaktır ve ToDo ya Eklediğiniz Görevler Silinecektir!!!',
          style: style(20, Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Center(
              child: Column(
            children: [
              ElevatedButton.icon(
                label: const Text("VAZGEÇ"),
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton.icon(
                label: const Text("ONAYLA"),
                icon: const Icon(
                  Icons.thumb_up_alt_rounded,
                ),
                onPressed: () {
                  localDataClearSave();
                  toDoDelete();
                  signOutUser();
                  Navigator.pushReplacementNamed(context, 'Login Page');
                },
              ),
            ],
          ))
        ],
      ),
    );
  }

  Future<void> toDoDatabaseVeriCek() async {
    _allTasks = await _localDatabase.getAllTask();
  }
}
