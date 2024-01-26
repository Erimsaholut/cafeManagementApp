import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  Order({
    super.key,
    required this.manualSetState,
    required this.toplamHesap,
    required this.maxCount,
    required this.textList,
    required this.price,
    required this.name,
  });

  final String name;
  final double price;

  final Function manualSetState;
  final int maxCount;
  List<String> textList;
  double toplamHesap;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late int initialValue;
  late String widgetName; // Added variable to store widget name

  @override
  void initState() {
    super.initState();
    initialValue = widget.maxCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (initialValue - 1 >= 0) {
                  initialValue = (initialValue - 1).clamp(0, widget.maxCount);
                  widgetName = widget.name;
                  widget.textList.add(widgetName);
                  widget.toplamHesap += widget.price;
                  print(widget.toplamHesap);
                  widget.manualSetState();
                }
              });
            },
            icon: const Icon(Icons.remove),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
          Text("$initialValue ${widget.name}",
              style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: () {
              setState(() {
                if (initialValue + 1 <= widget.maxCount) {
                  initialValue = (initialValue + 1).clamp(0, widget.maxCount);
                  widget.manualSetState();
                  widget.toplamHesap -= widget.price;
                  print(widget.toplamHesap);
                  widget.textList.remove(widgetName); // Remove widget name
                }
              });
            },
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
        ],
      ),
    );
  }
}
