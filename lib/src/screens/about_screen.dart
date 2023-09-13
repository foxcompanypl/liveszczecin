import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LiveSzczecin"),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(30.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dev by Foxcompany Łukasz Lis"),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: const Text.rich(
          TextSpan(
            style: TextStyle(
                height: 1.5,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
            children: [
              TextSpan(
                  text: 'LiveSzczecin',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      '  jest to autorski pomysł i projekt własciciela firmy'),
              TextSpan(
                  text: '  LANTECH',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "\n\n"),
              TextSpan(
                  text:
                      'Inicjatywa ma na celu pokazać Szczecin światu na żywo za pośrednictwem kamer HD rozmieszczonych w ciekawych miejscach.'),
              TextSpan(text: "\n\n"),
              TextSpan(
                  text:
                      'Do emitowania obrazu posiadamy własny serwer bazujący na maszynie firmy DELL i dedykowane oprogramowanie do transmisji obrazu i dźwięku w dowolnej jakości oraz co najważniejsze podpięte do naszej serwerowni światłowodowe łącza od trzech niezależnych dostawców, oprócz tego na terenie Szczecina posiadamy infrastrukturę sieciową (radiową oraz światłowodową), która umożliwia transmitowanie obrazu.'),
            ],
          ),
        ),
      ),
    );
  }
}
