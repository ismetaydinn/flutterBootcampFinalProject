import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/repo/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit<void> {

  DetaySayfaCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> sepeteYemekEkleCubit(String yemek_adi, String yemek_resim_adi, String yemek_fiyat, String yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}