import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';

class SaleQuantityGraph extends StatefulWidget {
  const SaleQuantityGraph({super.key});

  @override
  State<SaleQuantityGraph> createState() => _SaleQuantityGraphState();
}

class _SaleQuantityGraphState extends State<SaleQuantityGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Ürün Satış Adetleri"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: (){}, child: Text("Aylık",style: CustomTextStyles.blackAndBoldTextStyleM,)),
                      SizedBox(width: 20), // Araya bir boşluk ekleyerek hizalamayı düzenle
                      TextButton(onPressed: (){}, child: Text("Yıllık",style: CustomTextStyles.blackAndBoldTextStyleM,)),
                    ],
                  ),
                  const Text("2024 yılı x grafiği"),
                  Row(
                    children: [
                      IconButton(onPressed: () {  }, icon: const Icon(Icons.keyboard_arrow_left),),
                      SizedBox(width: 20), // Araya bir boşluk ekleyerek hizalamayı düzenle
                      Text("önceki\nay",textAlign: TextAlign.center,),
                      SizedBox(width: 20), // Araya bir boşluk ekleyerek hizalamayı düzenle
                      Text("sonraki\nay",textAlign: TextAlign.center,),
                      SizedBox(width: 20), // Araya bir boşluk ekleyerek hizalamayı düzenle
                      IconButton(onPressed: () {  }, icon: const Icon(Icons.keyboard_arrow_right),)
                    ],
                  )
                ],
              ),
            ),
          ),

          const Expanded(
            flex: 11,
            child: Row(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}




//todo flex yerine ekran boyutu yüzdelerini kullan
