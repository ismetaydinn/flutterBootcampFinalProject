import 'package:bitirme_projesi/entity/yemekler.dart';

class YemeklerCevap {

  List<Yemekler> yemekListesi;
  int success;

  YemeklerCevap({required this.yemekListesi, required this.success});

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    List<Yemekler> yemekListesi = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();
    int success = json["success"] as int;
    return YemeklerCevap(yemekListesi: yemekListesi, success: success);
  }
}