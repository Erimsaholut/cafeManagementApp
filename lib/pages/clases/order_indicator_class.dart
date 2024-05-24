import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../datas/table_orders_data/write_table_data.dart';
class OrderIndicatorButton extends StatelessWidget {
  final int quantity;
  final String itemName;
  final double price;
  final int tableNum;
  final Function initialFunction;

  const OrderIndicatorButton(
      {super.key,
        required this.quantity,
        required this.itemName,
        required this.price,
        required this.tableNum,
        required this.initialFunction,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "$quantity",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  itemName,
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "$price ₺",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                    onPressed: () => _showCancelDialog(context),
                    child: const Icon(Icons.clear_rounded, size: 18)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürün İptali'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('İptal etmek istediğiniz ürün adetini girin:'),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ürün sayısı',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                int? cancelQuantity = int.tryParse(controller.text);
                if (cancelQuantity == null ||
                    cancelQuantity <= 0 ||
                    cancelQuantity > quantity) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Geçersiz ürün sayısı')),
                  );
                } else {
                  WriteTableData writeTableData = WriteTableData();
                  Map<String, int> seperatedItem = {itemName: cancelQuantity};
                  await writeTableData.decreaseItemList(
                      tableNum, seperatedItem);
                  initialFunction();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}