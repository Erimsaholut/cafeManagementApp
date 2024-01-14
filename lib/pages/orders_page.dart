import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.orders});

  final List<Widget> orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sipariş Öde"),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.lime,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [...orders],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ödenecek hesap:  x ₺",
                    style: CustomStyles.menuTextStyle,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Onayla"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
