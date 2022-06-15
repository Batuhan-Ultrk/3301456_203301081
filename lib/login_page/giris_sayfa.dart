// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? eMail, pasword;
  var bilgiler = [];
  TextEditingController? controlPassword = TextEditingController();
  TextEditingController? controlEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FirebaseAuth auth;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controlPassword?.text = pasword ?? '';
    controlEmail?.text = eMail ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: style(
            27,
            Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        leading: IconButton(
          onPressed: () {
            bilgiler = ['0'];
            Navigator.pushReplacementNamed(context, 'Burc Listesi');
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
              size: 25,
            ),
          )
        ],
      ),
      body: Container(
        decoration: DecorationCreate(),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const Divider(
                    color: Colors.white,
                    thickness: 4,
                  ),
                  SizedBoxCreate(),
                  TextFromFieldCreate(
                    controlEmail,
                    'E Mail',
                    (data) {
                      if (EmailValidator.validate(data!)) {
                        return null;
                      } else {
                        return 'Geçerli bir mail adresi giriniz.';
                      }
                    },
                    (data) {
                      eMail = data!;
                    },
                    eMail,
                    TextInputType.emailAddress,
                    Icons.email_rounded,
                  ),
                  SizedBoxCreate(),
                  const Divider(
                    color: Colors.white,
                    thickness: 4,
                  ),
                  SizedBoxCreate(),
                  TextFromFieldCreate(
                    controlPassword,
                    'Password',
                    (data) {
                      if (data!.length < 8) {
                        return 'Password en az 8 karakter uzunluğunda olmalıdır.';
                      } else {
                        return null;
                      }
                    },
                    (data) {
                      pasword = data!;
                      return null;
                    },
                    pasword,
                    TextInputType.text,
                    Icons.password,
                    gizle: false,
                  ),
                  SizedBoxCreate(),
                  SizedBoxCreate(),
                  const Divider(
                    color: Colors.white,
                    thickness: 4,
                  ),
                  SizedBoxCreate(),
                  SizedBoxCreate(),
                  ElevatedButtonCreate(
                    'Temizle',
                    'Clear',
                    Icons.clear_all_rounded,
                  ),
                  ElevatedButtonCreate(
                    'Giriş Yap',
                    'Login',
                    Icons.login_rounded,
                  ),
                  SizedBoxCreate(),
                  SizedBoxCreate(),
                  SizedBoxCreate(),
                  SizedBoxCreate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField TextFromFieldCreate(
      TextEditingController? control,
      String text,
      String? Function(String?)? Validator,
      String? Function(String?)? onSaved,
      String? gosterilecekVeri,
      TextInputType keyboardType,
      IconData shape,
      {int line = 1,
      int lenght = 100,
      bool gizle = false}) {
    return TextFormField(
      controller: control,
      readOnly: false,
      style: style(18, Colors.white),
      cursorColor: Colors.black,
      cursorWidth: 2,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: line,
      maxLength: lenght,
      decoration: DecoratinStyle(text, shape),
      validator: Validator,
      onSaved: onSaved,
      obscureText: gizle,
      // initialValue: gosterilecekVeri,
    );
  }

  Widget ElevatedButtonCreate(String toastText, String text, IconData shape) {
    return Padding(
      padding: const EdgeInsets.only(left: 65, top: 8, bottom: 8),
      child: Container(
        alignment: Alignment.bottomLeft,
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
              _formKey.currentState!.reset();
              eMail = '';
              pasword = '';
              setState(
                () {},
              );
            } else {
              bool _validate = false;
              _validate = _formKey.currentState!.validate();
              _formKey.currentState?.save();
              loginControl(_validate);
            }
          },
          label: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          icon: Icon(shape, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 17,
            fixedSize: const Size(210, 50),
            shadowColor: Colors.grey,
            side: const BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox SizedBoxCreate() {
    return const SizedBox(
      height: 12,
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
      labelStyle: style(17, Colors.indigo),
      hintText: DataName,
      hintStyle: style(18, Colors.indigo),
      filled: true,
      fillColor: Colors.amber,
    );
  }

  void Gonder(bool _validate) {
    if (_validate) {
      bilgiler = [eMail, '0'];
      Navigator.pushReplacementNamed(
        context,
        'Profile Page',
        arguments: bilgiler,
        result: bilgiler,
      );
    }
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

  TextStyle style(double size, Color colorss) {
    return GoogleFonts.quicksand(
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: colorss,
    );
  }

  Future<void> loginControl(_validate) async {
    try {
      var _userControl = await auth.signInWithEmailAndPassword(
          email: eMail!, password: pasword!);
      Gonder(_validate);
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showToast(
        'Kullanıcı Bulunamadı Lütfen Bilgilerinizi Kontrol ediniz',
        duration: const Duration(
          seconds: 3,
        ),
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }
}
