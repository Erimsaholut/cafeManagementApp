import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../constants/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key, required this.initialOrders});

  final List<String> initialOrders;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late List<String> orders;

  @override
  void initState() {
    super.initState();
    orders = widget.initialOrders;
  }
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
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(orders[index]),
                ),
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
                    "Ödenecek hesap: ${calculateTotal()} ₺",
                    style: CustomStyles.blackAndBoldTextStyleXl,
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

  double calculateTotal() {
    // Burada siparişlerin toplam tutarı hesaplanabilir.
    // Örneğin, orders listesindeki ürün fiyatları üzerinden bir toplama yapılabilir.
    // Bu örnekte basitçe bir sabit değeri döndürüyorum.
    return 100.0;
  }
}
