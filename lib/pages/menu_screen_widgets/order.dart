import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  Order({
    Key? key,
    required this.manualSetState,
    required this.arttirToplamHesap,
    required this.azaltToplamHesap,
    required this.toplamHesap,
    required this.maxCount,
    required this.textList,
    required this.price,
    required this.name,
  }) : super(key: key);

  final String name;
  final double price;

  final Function manualSetState;
  final Function arttirToplamHesap;
  final Function azaltToplamHesap;
  final int maxCount;
  List<String> textList;
  double toplamHesap;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late int initialValue;
  late String widgetName;

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
        overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.green.shade400; // Change this color as needed
            }
            return Colors.transparent;
          },
        ),
      ),
      onPressed: () {
        setState(() {
          widgetName = widget.name;

          /* burası toplu ekleme burayı en son kullan*/

          for (int i = 0; initialValue > i; i++) {
            widget.textList.add(widgetName);
            widget.arttirToplamHesap(widget.price);
          }

          widget.toplamHesap = widget.price * initialValue;
          print("Toplam Hesap: ${widget.toplamHesap}");

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
                initialValue = (initialValue - 1).clamp(0, widget.maxCount);
                widgetName = widget.name;
                widget.textList.add(widgetName);

                widget.arttirToplamHesap(widget.price);

                widget.manualSetState();
                print("Azalt");
                print("Toplam Hesap: ${widget.toplamHesap}");

                widget.manualSetState();
              });
            }
                : null,
            icon: const Icon(Icons.remove),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
          Text("$initialValue ${widget.name}", style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: initialValue < widget.maxCount
                ? () {
              setState(() {
                initialValue = (initialValue + 1).clamp(0, widget.maxCount);

                widget.textList.remove(widgetName); // Remove widget name

                widget.azaltToplamHesap(widget.price);
                widget.manualSetState();
                print("Arttır");
                print("Toplam Hesap: ${widget.toplamHesap}");
              });
            }
                : null,
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
