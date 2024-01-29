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
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green.withOpacity(0.3)),
        // Highlight color for the button
        overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.green.shade400; // Change this color as needed
            }
            // The default color
            return Colors.transparent;
          },
        ),
      ),
      onPressed: () {
        setState(() {
          widgetName = widget.name;
          for(int i = 0;initialValue>i;i++){
            widget.textList.add(widgetName);
          }

          widget.toplamHesap += widget.price;
          print(widget.toplamHesap);
          initialValue = 0;
          widget.manualSetState();
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: initialValue > 0
                ? () {
                    setState(() {

                      initialValue =
                          (initialValue - 1).clamp(0, widget.maxCount);
                      widgetName = widget.name;
                      widget.textList.add(widgetName);
                      widget.manualSetState();
                    });
                  }
                : null,
            icon: const Icon(Icons.remove),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
          Text("$initialValue ${widget.name}",
              style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: initialValue < widget.maxCount
                ? () {
                    setState(() {
                      initialValue =
                          (initialValue + 1).clamp(0, widget.maxCount);

                      widget.textList
                          .remove(widgetName); // Remove widget name


                      widget.manualSetState();

                    });
                  }
                : null,
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
        ],
      ),
    );
  }
}
