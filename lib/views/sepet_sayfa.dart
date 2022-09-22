import 'package:bitirme_projesi/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/entity/sepet.dart';
import 'package:bitirme_projesi/repo/yemeklerdao_repo.dart';
import 'package:bitirme_projesi/views/onay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  int fiyat = 0;
  int toplamFiyat = 0;
  String kullanici_adi = "iaydin98";

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepettekileriAlCubit(kullanici_adi);
  }

  var yemekListesi = [];
  var index = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
        titleTextStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_outlined)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
                child: Text(kullanici_adi, style: TextStyle(fontSize: 16.0),
                ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SepetSayfaCubit, List<Sepet>>(
          builder: (context, sepetListesi) {
            if (sepetListesi.isNotEmpty) {
              return ListView.builder(
                  itemCount: sepetListesi.length,
                  itemBuilder: (context, indeks) {
                    var sepet = sepetListesi[indeks];
                    fiyat = YemeklerDaoRepo().toplamFiyatHesaplama(sepet.yemek_fiyat, sepet.yemek_siparis_adet);
                    if (index.contains(sepet.sepet_yemek_id) == false){
                      if (yemekListesi.contains(sepet.yemek_adi)){
                        toplamFiyat -= fiyat;
                      }
                      index.add(sepet.sepet_yemek_id);
                      toplamFiyat += fiyat;
                      context.read<SepetSayfaIslemCubit>().islem(toplamFiyat);
                    }
                    return Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: 135.0,
                                    width: 135.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          color: Colors.red.shade100,
                                          child: Image.network(
                                            "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                          )
                                      ),
                                    )
                                ),
                                SizedBox(
                                  width: 200.0,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(sepet.yemek_adi, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.red.shade900),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Center(
                                              child: Text("${sepet.yemek_siparis_adet} adet", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0, color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text("$fiyat ₺", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 120,
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${sepet.yemek_adi} silinsin mi?"),
                                          action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              toplamFiyat = 0;
                                              yemekListesi = [];
                                              index = [];
                                              context.read<SepetSayfaIslemCubit>().islem(toplamFiyat);
                                              context.read<SepetSayfaCubit>().sepettenYemekSilCubit(sepet.sepet_yemek_id, kullanici_adi);
                                            },
                                          ),
                                        )
                                        );
                                      },
                                      icon: const Icon(Icons.delete_outline,),
                                    ),
                                  ]
                              ),
                            ),
                          ]
                      ),
                    );
                  }
              );
            }else{
              return const Center();
            }
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 200,
              child: FloatingActionButton.extended(
                label: const Text("Sipariş Ver", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                onPressed: () {
                  if(toplamFiyat != 0) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OnaySayfa()))
                        .then((value) => Navigator.pop(context));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sepetiniz boş", style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,),
                      backgroundColor: Colors.red,
                    ),
                    );
                  }
                },
              ),
            ),
            FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Colors.white,
              onPressed: (){
              },
              label: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: BlocBuilder<SepetSayfaIslemCubit, int>(
                      builder: (context, fiyat){
                        if (fiyat == 0){
                          return const SizedBox();
                        }else{
                          return Text("$fiyat ₺", style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: Colors.red),);
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}