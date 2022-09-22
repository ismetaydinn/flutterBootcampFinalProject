import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/repo/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<Sepet>> {

  SepetSayfaCubit() : super(<Sepet>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> sepettekileriAlCubit(String kullanici_adi) async {
    var liste = await yrepo.sepettekileriAl(kullanici_adi);
    emit(liste);
  }

  Future sepettenYemekSilCubit(String sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepettekileriAlCubit(kullanici_adi);
  }
}

class SepetSayfaIslemCubit extends Cubit<int> {
  SepetSayfaIslemCubit() : super(0);

  void islem(islem) {
    emit(islem);
  }
}