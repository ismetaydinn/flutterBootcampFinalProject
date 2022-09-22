import 'package:bitirme_projesi/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/views/detay_sayfa.dart';
import 'package:bitirme_projesi/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriAlCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text("Yemekler", style: TextStyle(fontSize: 24.0 ,fontWeight: FontWeight.w500),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
              },
              icon: const Icon(Icons.shopping_cart_outlined, size: 26.0,)),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: yemeklerListesi.length,
              itemBuilder: (context, indeks) {
                var yemek = yemeklerListesi[indeks];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                    },
                    child: Card(
                      color: Colors.blueGrey.shade50,
                      child: SizedBox(
                        height: 135.0,
                        child: Row(
                          children: [
                            SizedBox(
                                height: 135.0,
                                width: 135.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.red.shade100,
                                    child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(yemek.yemek_adi, textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 24.0, color: Colors.red.shade900, fontWeight: FontWeight.w500),),
                                  Text("${yemek.yemek_fiyat} ₺", textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.w500,),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
    );
  }
}