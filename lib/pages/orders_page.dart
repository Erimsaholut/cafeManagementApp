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
      body: Container(
        color: Colors.lime,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [...orders],
              ),
            ),
            const Expanded(
                child: Column(
              children: [
                Text("Öde"),
                Text("ya da "),
                Text("Ödeme"),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
