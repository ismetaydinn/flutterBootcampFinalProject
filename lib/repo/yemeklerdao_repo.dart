import 'dart:convert';
import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/entity/sepet_cevap.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepo{

  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekListesi;
  }

  List<Sepet> parseSepetYemeklerCevap(String cevap){
    return SepetCevap.fromJson(json.decode(cevap)).sepettekilerListesi;
  }

  Future<List<Yemekler>> yemekleriAl() async {

    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, String yemek_fiyat, String yemek_siparis_adet, String kullanici_adi) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi,};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek ekle : ${cevap.data.toString()}");
  }

  Future<List<Sepet>> sepettekileriAl(String kullanici_adi) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    try {
      return parseSepetYemeklerCevap(cevap.data.toString());
    } catch (e) {
      return [];
    }
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id, String kullanici_adi) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek sil: ${cevap.data.toString()}");

  }

  int toplamFiyatHesaplama(String fiyat, String adet){
    int intFiyat = int.parse(fiyat);
    int intAdet = int.parse(adet);
    int toplam = intFiyat * intAdet;
    return toplam;
  }
}
