import 'package:bitirme_projesi/views/anasayfa.dart';
import 'package:flutter/material.dart';

class OnaySayfa extends StatefulWidget {
  const OnaySayfa({Key? key}) : super(key: key);

  @override
  State<OnaySayfa> createState() => _OnaySayfaState();
}

class _OnaySayfaState extends State<OnaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("resimler/tik.png"),
            const Text("Siparişiniz alınmıştır.", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
                },
                child: const Text("Anasayfaya dön"))
          ],
        ),
      ),
    );
  }
}