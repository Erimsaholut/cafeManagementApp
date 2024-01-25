import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen_widgets/order.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../constants/colors.dart';

/*  sadece azalt butonlarının olduğu o sayfa*/

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key, required this.initialOrders});

  final Map<String, dynamic>? initialOrders;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Widget> orders = [];

  @override
  void initState() {
    super.initState();
    print(widget.initialOrders);
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
              child: FutureBuilder<List<Widget>>(
                future: setTableData(widget.initialOrders),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    orders = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return orders[index];
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
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
    return 100.0;
  }

  Future<List<Widget>> setTableData(Map<String, dynamic>? tableData) async {
    List<Widget> list = [];

    print(tableData);
    if (tableData?["orders"] != null) {
      for (var i in tableData?["orders"]!) {
        list.add(Order(initialCount: i["quantity"], name: i["name"]));
      }
    }
    return list;
  }
}
