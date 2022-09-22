import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/repo/yemeklerdao_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {

  AnasayfaCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepo();

  Future<void> yemekleriAlCubit() async {
    var liste = await yrepo.yemekleriAl();
    emit(liste);
  }
}