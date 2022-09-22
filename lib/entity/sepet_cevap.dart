import 'package:bitirme_projesi/entity/sepet.dart';

class SepetCevap {

  List<Sepet> sepettekilerListesi;
  int success;

  SepetCevap({required this.sepettekilerListesi, required this.success});

  factory SepetCevap.fromJson(Map<String, dynamic> json) {

    var jsonArray = json["sepet_yemekler"] as List;
    List<Sepet> sepettekilerListesi = jsonArray.map((jsonArrayNesnesi) => Sepet.fromJson(jsonArrayNesnesi)).toList();
    int success = json["success"] as int;
    return SepetCevap(sepettekilerListesi: sepettekilerListesi, success: success);
  }
}