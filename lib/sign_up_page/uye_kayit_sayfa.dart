// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
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

class _SignUpPageState extends State<SignUpPage> {
  int aktifstep = 0;
  late List<Step> Steps;
  String _username = '',
      _pasword = '',
      _eMail = '',
      _dogumTarih = '',
      _cinsiyet = '',
      _aboutMe = '',
      _number = '',
      _age = '',
      _burc = '';
  var bilgiler = [];
  bool error = false;

  late FirebaseAuth auth;
  late FirebaseFirestore firestore;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    super.initState();
  }

  TextStyle StyleCreate(Color colorss, double size) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  //final _formKey = GlobalKey<FormState>();
  final key0 = GlobalKey<FormFieldState>();
  final key1 = GlobalKey<FormFieldState>();
  final key2 = GlobalKey<FormFieldState>();
  final key3 = GlobalKey<FormFieldState>();
  final key4 = GlobalKey<FormFieldState>();
  final key5 = GlobalKey<FormFieldState>();
  final key6 = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    Steps = allSteps();
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, 'Burc Listesi');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: StyleCreate(Colors.white, 25),
          ),
          centerTitle: true,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, 'Burc Listesi');
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Çıkış',
              onPressed: () {
                exit(0);
              },
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: Container(
          decoration: DecorationCreate(),
          //color: Colors.yellow.shade100,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Stepper(
                    controlsBuilder: ((context, details) {
                      return Row(
                        children: [
                          ElevatedButtonCreateControls(
                              context,
                              details.onStepContinue,
                              'Continue',
                              Icons.arrow_forward_ios_rounded,
                              'Devam'),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButtonCreateControls(
                              context,
                              details.onStepCancel,
                              'Back',
                              Icons.arrow_back_ios_rounded,
                              'Geri'),
                        ],
                      );
                    }),
                    physics: const ScrollPhysics(),
                    steps: Steps,
                    currentStep: aktifstep,
                    /*  onStepTapped: (selectStep) {
                      setState(
                        () {
                          aktifstep = selectStep;
                        },
                      );
                    }, */
                    onStepContinue: () {
                      setState(() {
                        continueKontrol();
                      });
                    },
                    onStepCancel: () {
                      setState(
                        () {
                          if (aktifstep > 0) {
                            aktifstep--;
                          }
                        },
                      );
                    },
                  ),
                  const Text(
                    '* Zorunlu Alan',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButtonCreate(
                        'Tüm Verileri Temizle',
                        'Clear',
                        Icons.clear_all_rounded,
                      ),
                      ElevatedButtonCreate(
                        'Kayıt Ol',
                        'Sign Up',
                        Icons.login_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Step> allSteps() {
    List<Step> steps = [
      Step(
        state: stateAyar(0, key0),
        isActive: true,
        title: Text(
          'Username *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('Kullanıcı Adı'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFromFieldCreate(
            key0,
            'Username',
            (data) {
              if (data!.length < 4) {
                return 'Username en az 4 karakter olmalıdır.';
              } else {
                return null;
              }
            },
            (data) {
              _username = data!;
            },
            TextInputType.text,
            Icons.account_circle_sharp,
          ),
        ),
      ),
      Step(
        state: stateAyar(1, key1),
        isActive: true,
        title: Text(
          'E mail *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('E mail'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFromFieldCreate(
            key1,
            'E Mail',
            (data) {
              if (EmailValidator.validate(data!)) {
                return null;
              } else {
                return 'Geçerli bir mail adresi giriniz.';
              }
            },
            (data) {
              _eMail = data!;
            },
            TextInputType.emailAddress,
            Icons.email_rounded,
          ),
        ),
      ),
      Step(
        state: stateAyar(2, key2),
        isActive: true,
        title: Text(
          'Phone Number *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('Telefon Numarası'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFromFieldCreate(
            key2,
            'Phone Number',
            (data) {
              if (data!.length < 11) {
                return 'Geçerli bir telefon numarası giriniz.';
              } else {
                return null;
              }
            },
            (data) {
              _number = data!;
            },
            TextInputType.number,
            Icons.phone_android_rounded,
            lenght: 11,
          ),
        ),
      ),
      Step(
        state: stateAyar(3, key3),
        isActive: true,
        title: Text(
          'Gender *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('Cinsiyet'),
        content: DropDownButtonCreate(
          key3,
          [
            'Erkek',
            'Kadın',
          ],
          'Cinsiyet Seçiniz',
          _cinsiyet,
          (String? data) {
            _cinsiyet = data!;
          },
        ),
      ),
      Step(
        state: stateAyar(4, key4),
        isActive: true,
        title: Text(
          'Date Of Birth *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('Doğum Tarihi'),
        content: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButtonStyle(false),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.parse('1920-01-01'),
                    lastDate: DateTime.now(),
                  ).then((secilenDate) {
                    _dogumTarih =
                        (formatDate(secilenDate!, [yyyy, '-', mm, '-', dd]));

                    Duration dur = DateTime.now().difference(secilenDate);
                    _age = (dur.inDays / 365).floor().toString();

                    if ((secilenDate.month == 3 && secilenDate.day >= 21) ||
                        (secilenDate.month == 4 && secilenDate.day <= 20)) {
                      _burc = 'KOÇ';
                    } else if ((secilenDate.month == 4 &&
                            secilenDate.day >= 21) ||
                        (secilenDate.month == 5 && secilenDate.day <= 21)) {
                      _burc = 'BOĞA';
                    } else if ((secilenDate.month == 5 &&
                            secilenDate.day >= 22) ||
                        (secilenDate.month == 6 && secilenDate.day <= 22)) {
                      _burc = 'İKİZLER';
                    } else if ((secilenDate.month == 6 &&
                            secilenDate.day >= 23) ||
                        (secilenDate.month == 7 && secilenDate.day <= 22)) {
                      _burc = 'YENGEÇ';
                    } else if ((secilenDate.month == 7 &&
                            secilenDate.day >= 23) ||
                        (secilenDate.month == 8 && secilenDate.day <= 22)) {
                      _burc = 'ASLAN';
                    } else if ((secilenDate.month == 8 &&
                            secilenDate.day >= 23) ||
                        (secilenDate.month == 9 && secilenDate.day <= 22)) {
                      _burc = 'BAŞAK';
                    } else if ((secilenDate.month == 9 &&
                            secilenDate.day >= 23) ||
                        (secilenDate.month == 10 && secilenDate.day <= 22)) {
                      _burc = 'TERAZİ';
                    } else if ((secilenDate.month == 10 &&
                            secilenDate.day >= 23) ||
                        (secilenDate.month == 11 && secilenDate.day <= 21)) {
                      _burc = 'AKREP';
                    } else if ((secilenDate.month == 11 &&
                            secilenDate.day >= 22) ||
                        (secilenDate.month == 12 && secilenDate.day <= 21)) {
                      _burc = 'YAY';
                    } else if ((secilenDate.month == 12 &&
                            secilenDate.day >= 22) ||
                        (secilenDate.month == 1 && secilenDate.day <= 21)) {
                      _burc = 'OĞLAK';
                    } else if ((secilenDate.month == 1 &&
                            secilenDate.day >= 22) ||
                        (secilenDate.month == 2 && secilenDate.day <= 19)) {
                      _burc = 'KOVA';
                    } else if ((secilenDate.month == 2 &&
                            secilenDate.day >= 20) ||
                        (secilenDate.month == 3 && secilenDate.day <= 20)) {
                      _burc = 'BALIK';
                    }
                  });
                },
                onLongPress: () {
                  EasyLoading.showToast(
                    'Doğum Tarihi Seçiniz',
                    duration: const Duration(
                      seconds: 3,
                    ),
                    toastPosition: EasyLoadingToastPosition.center,
                  );
                },
                icon: const Icon(
                  Icons.date_range_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                label: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Choose Date Of Birth',
                    style: StyleCreate(Colors.white, 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: stateAyar(5, key5),
        isActive: true,
        title: Text(
          'About Me',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text('Hakkımda'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFromFieldCreate(
            key5,
            'About Me',
            null,
            (data) {
              _aboutMe = data!;
            },
            TextInputType.text,
            Icons.data_saver_on_rounded,
            lenght: 100,
            line: 4,
          ),
        ),
      ),
      Step(
        state: stateAyar(6, key6),
        isActive: true,
        title: Text(
          'Password *',
          style: StyleCreate(Colors.black, 18),
        ),
        subtitle: const Text(
          'Şifre',
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFromFieldCreate(
            key6,
            'Password',
            (data) {
              if (data!.length < 8) {
                return 'Password en az 8 karakter uzunluğunda olmalıdır.';
              } else {
                return null;
              }
            },
            (data) {
              _pasword = data!;
            },
            TextInputType.text,
            Icons.password,
            gizle: true,
          ),
        ),
      ),
    ];
    return steps;
  }

  Padding ElevatedButtonCreate(String toastText, String text, IconData shape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onLongPress: () {
          EasyLoading.showToast(
            toastText,
            duration: const Duration(
              seconds: 3,
            ),
            toastPosition: EasyLoadingToastPosition.center,
          );
        },
        onPressed: () {
          if (text == 'Clear') {
            key0.currentState!.reset();
            key1.currentState!.reset();
            key2.currentState!.reset();
            key3.currentState!.reset();
            // key4.currentState!.reset();
            _dogumTarih = '';
            key5.currentState!.reset();
            key6.currentState!.reset();
            setState(() {
              aktifstep = 0;
            });
          } else {
            if (key0.currentState!.validate() &&
                key1.currentState!.validate() &&
                key2.currentState!.validate() &&
                key3.currentState!.validate() &&
                (_dogumTarih != '' && _dogumTarih != 'null') &&
                key5.currentState!.validate() &&
                key6.currentState!.validate()) {
              key6.currentState!.save();
              bilgiler = [
                _eMail,
              ];
            } else {
              EasyLoading.showToast(
                'LÜTFEN İSTENİLEN BİLGİLERİ GİRİNİZ!!',
                duration: const Duration(
                  seconds: 3,
                ),
                toastPosition: EasyLoadingToastPosition.center,
              );
            }
          }
        },
        label: Text(
          text,
          style: StyleCreate(Colors.white, 16),
        ),
        icon: Icon(
          shape,
          color: Colors.white,
        ),
        style: ElevatedButtonStyle(true),
      ),
    );
  }

  TextFormField TextFromFieldCreate(
      Key keys,
      String text,
      String? Function(String?)? Validator,
      String? Function(String?)? onSaved,
      TextInputType keyboardType,
      IconData shape,
      {int line = 1,
      int lenght = 100,
      bool gizle = false}) {
    return TextFormField(
      readOnly: false,
      style: StyleCreate(Colors.white, 18),
      cursorColor: Colors.black,
      cursorWidth: 2,
      key: keys,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: line,
      maxLength: lenght,
      decoration: DecoratinStyle(text, shape),
      validator: Validator,
      onSaved: onSaved,
      obscureText: gizle,
    );
  }

  DropdownButtonFormField<String> DropDownButtonCreate(
    Key keys,
    List<String> Liste,
    String text,
    String save,
    String? Function(String?)? onSaved,
  ) {
    return DropdownButtonFormField(
      key: keys,
      validator: (data) {
        if (data == null) {
          return text + ' seçiniz.';
        } else {
          return null;
        }
      },
      autofocus: true,
      dropdownColor: Colors.orange,
      iconSize: 27,
      decoration: const InputDecoration(
        errorStyle: TextStyle(
          color: Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(
        Icons.details,
        color: Colors.blue,
      ),
      alignment: Alignment.center,
      style: StyleCreate(Colors.black, 18),
      hint: Text(
        text,
        style: StyleCreate(Colors.indigo, 18),
      ),
      items: Liste.map(
        (String e) => DropdownMenuItem(
          child: Text(e),
          value: e,
        ),
      ).toList(),
      onSaved: onSaved,
      onChanged: (String? veri) {
        setState(
          () {
            save = veri!;
          },
        );
      },
    );
  }

  InputDecoration DecoratinStyle(String DataName, IconData DataIcon) {
    return InputDecoration(
      errorStyle: const TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      prefix: Icon(
        DataIcon,
        color: Colors.blueAccent,
      ),
      border: const OutlineInputBorder(
        gapPadding: 5,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        borderSide: BorderSide.none,
      ),
      labelText: DataName,
      labelStyle: StyleCreate(Colors.indigo, 17),
      hintText: DataName,
      hintStyle: StyleCreate(Colors.indigo, 18),
      filled: true,
      fillColor: Colors.amber,
    );
  }

  StepState stateAyar(int index, key) {
    if (aktifstep == index) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else if ((key.currentState?.validate() ?? false) || _dogumTarih != '') {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  void continueKontrol() {
    switch (aktifstep) {
      case 0:
        kontrol(key0);
        break;
      case 1:
        kontrol(key1);
        break;
      case 2:
        kontrol(key2);
        break;
      case 3:
        kontrol(key3);
        break;
      case 4:
        kontrol(key4);
        break;
      case 5:
        kontrol(key5);
        break;
      case 6:
        kontrol(key6);
        break;
      default:
    }
  }

  void kontrol(key) {
    if (key == key4) {
      if (_dogumTarih != '' && _dogumTarih != 'null') {
        error = false;
        if (aktifstep < Steps.length - 1) {
          aktifstep++;
        }
      } else {
        error = true;
      }
    } else if (key.currentState?.validate() ?? false) {
      key.currentState!.save();
      error = false;
      if (aktifstep < Steps.length - 1) {
        aktifstep++;
      }
    } else {
      error = true;
    }
  }

  ElevatedButton ElevatedButtonCreateControls(
      var context, var details, String text, IconData shape, String toastText) {
    return ElevatedButton.icon(
      onLongPress: () {
        EasyLoading.showToast(
          toastText,
          duration: const Duration(
            seconds: 3,
          ),
          toastPosition: EasyLoadingToastPosition.center,
        );
      },
      onPressed: details,
      icon: Icon(
        shape,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: StyleCreate(Colors.white, 14),
      ),
      style: ElevatedButtonStyle(false),
    );
  }

  ElevatedButtonStyle(bool sizeUse) {
    if (sizeUse) {
      return ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 17,
        fixedSize: const Size(130, 50),
        shadowColor: Colors.grey,
        side: const BorderSide(
          style: BorderStyle.solid,
          color: Colors.black,
        ),
      );
    } else {
      return ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 17,
        shadowColor: Colors.grey,
        side: const BorderSide(
          style: BorderStyle.solid,
          color: Colors.black,
        ),
      );
    }
  }

  Future<void> createUser() async {
    try {
      String _kayitTarih = DateTime.now().toString();
      var _user = await auth.createUserWithEmailAndPassword(
        email: _eMail,
        password: _pasword,
      );

      Map<String, dynamic> usersDetay = {};

      usersDetay['E Mail'] = _eMail;
      usersDetay['Username'] = _username;
      usersDetay['Phone Number'] = _number;
      usersDetay['Gender'] = _cinsiyet;
      usersDetay['Date Of Birth'] = _dogumTarih;
      usersDetay['Age'] = _age;
      usersDetay['Burç'] = _burc;
      usersDetay['About Me'] = _aboutMe;
      usersDetay['date of registration'] = _kayitTarih;
      await firestore.doc('users/$_eMail').set(usersDetay);

      Navigator.pushReplacementNamed(
        context,
        'Login Page',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
