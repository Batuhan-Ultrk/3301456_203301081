import 'dart:io';
import 'package:burc_rehberi/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '',
      _pasword = '',
      _eMail = '',
      _burc = '',
      _cinsiyet = '',
      _aboutMe = '',
      _number = '';
  var bilgiler = null;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bilgiler = ['0'];
        Navigator.pop(context, bilgiler);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              bilgiler = ['0'];
              Navigator.pop(context, bilgiler);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Çıkış',
              onPressed: () {
                exit(0);
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBoxCreate(),
                  TextFromFieldCreate(
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
                  SizedBoxCreate(),
                  TextFromFieldCreate(
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
                  SizedBoxCreate(),
                  TextFromFieldCreate(
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
                  SizedBoxCreate(),
                  DropDownButtonCreate(
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
                  SizedBoxCreate(),
                  DropDownButtonCreate(
                    Strings.BURC_ADLARI,
                    'Burç Seçiniz',
                    _burc,
                    (String? data) {
                      _burc = data!;
                    },
                  ),
                  SizedBoxCreate(),
                  TextFromFieldCreate(
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
                  SizedBoxCreate(),
                  TextFromFieldCreate(
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
                  Row(
                    children: [
                      ElevatedButtonCreate(
                        'Tüm Verileri Temizle',
                        'Clear',
                        Icons.clear_all_rounded,
                      ),
                      ElevatedButtonCreate(
                        'Giriş Yap',
                        'Login',
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

  TextFormField TextFromFieldCreate(
      String text,
      String? Function(String?)? Validator,
      String? Function(String?)? onSaved,
      TextInputType keyboardType,
      IconData shape,
      {int line = 1,
      int lenght = 100,
      bool gizle = false}) {
    return TextFormField(
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

  Padding ElevatedButtonCreate(String toastText, String text, IconData shape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.bottomLeft,
        child: ElevatedButton.icon(
          onLongPress: () {
            EasyLoading.showToast(
              toastText,
              duration: Duration(
                seconds: 3,
              ),
              toastPosition: EasyLoadingToastPosition.center,
            );
          },
          onPressed: () {
            if (text == 'Clear') {
              _formKey.currentState!.reset();
            } else {
              bool _validate = _formKey.currentState!.validate();
              if (_validate) {
                _formKey.currentState?.save();
                bilgiler = [
                  _username,
                  _eMail,
                  _number,
                  _cinsiyet,
                  _burc,
                  _aboutMe,
                  _pasword
                ];
                //  print(bilgiler);
                Navigator.pushReplacementNamed(
                  context,
                  'Profile Page',
                  arguments: bilgiler,
                  result: bilgiler,
                );
              }
            }
          },
          label: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(shape, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            elevation: 17,
            fixedSize: Size(130, 50),
            shadowColor: Colors.grey,
            side: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox SizedBoxCreate() {
    return SizedBox(
      height: 12,
    );
  }

  DropdownButtonFormField<String> DropDownButtonCreate(List<String> Liste,
      String text, String save, String? Function(String?)? onSaved) {
    return DropdownButtonFormField(
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
        text,
        style: TextStyle(
          fontSize: 17,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
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
      errorStyle: TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      prefix: Icon(
        DataIcon,
        color: Colors.blue,
      ),
      border: OutlineInputBorder(
        gapPadding: 5,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      labelText: DataName,
      labelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      hintText: DataName,
      hintStyle: TextStyle(
        color: Colors.blueGrey,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
