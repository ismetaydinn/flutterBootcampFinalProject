import 'package:bitirme_projesi/cubit/detay_sayfa_cubit.dart';
import 'package:bitirme_projesi/entity/yemekler.dart';
import 'package:bitirme_projesi/repo/yemeklerdao_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {

  Yemekler yemek;
  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {

  int sayac = 0;

  @override
  Widget build(BuildContext context) {

    int toplamFiyat = YemeklerDaoRepo().toplamFiyatHesaplama(widget.yemek.yemek_fiyat, sayac.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemek Detay"),
        titleTextStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_outlined)
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${widget.yemek.yemek_adi}", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.black54),),
                SizedBox(
                  child: SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Image.network(
                      "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Adet Fiyat:   ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            Text("${widget.yemek.yemek_fiyat} ₺", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ]
                      ),
                    ]
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Toplam Fiyat:   ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    Text("$toplamFiyat ₺", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black54,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                          child: IconButton(
                              onPressed: (){
                                if(sayac == 0){
                                  setState((){
                                    sayac = 0;
                                  });
                                }else{
                                  setState((){
                                    sayac--;
                                  });
                                }
                              },
                              icon: Icon(Icons.remove, size: 16,)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("$sayac", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black54,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  sayac++;}
                                );},
                              icon: Icon(Icons.add, size: 16,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 45,
        child: FloatingActionButton.extended(
          tooltip: "Siparis",
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icon(Icons.add),
          label: Text("Sepete Ekle"),
          onPressed: (){
            if(sayac == 0){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("İşlem başarısız", textAlign: TextAlign.center), backgroundColor: Colors.red,),);
            }else{
              setState(() {
                var kullanici_adi = "iaydin98";
                context.read<DetaySayfaCubit>().sepeteYemekEkleCubit(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, widget.yemek.yemek_fiyat, sayac.toString(), kullanici_adi);
                Navigator.of(context).pop();
              });
            }
          },
        ),
      ),
    );
  }
}