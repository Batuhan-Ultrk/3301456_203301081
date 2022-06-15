// ignore_for_file: file_names

import 'dart:convert';

MitolojiModel mitolojiModelFromMap(String str) =>
    MitolojiModel.fromMap(json.decode(str));

String mitolojiModelToMap(MitolojiModel data) => json.encode(data.toMap());

class MitolojiModel {
  MitolojiModel({
    required this.burc,
  });

  final List<Burc> burc;

  factory MitolojiModel.fromMap(Map<String, dynamic> json) => MitolojiModel(
        burc: List<Burc>.from(json["Burc"].map((x) => Burc.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Burc": List<dynamic>.from(burc.map((x) => x.toMap())),
      };
}

class Burc {
  Burc({
    required this.burc,
    required this.baslik,
    required this.detay1,
    required this.detay2,
    required this.detay3,
  });

  final String burc;
  final String baslik;
  final String detay1;
  final String detay2;
  final String detay3;

  factory Burc.fromMap(Map<String, dynamic> json) => Burc(
        burc: json["burc"],
        baslik: json["baslik"],
        detay1: json["detay1"],
        detay2: json["detay2"],
        detay3: json["detay3"],
      );

  Map<String, dynamic> toMap() => {
        "burc": burc,
        "baslik": baslik,
        "detay1": detay1,
        "detay2": detay2,
        "detay3": detay3,
      };
}
