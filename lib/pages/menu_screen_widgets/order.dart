import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  Order({Key? key, required this.initialCount, required this.name}) : super(key: key);

  int initialCount;
  String name;

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                count = count - 1;
              });
            },
            icon: const Icon(Icons.remove),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            ),
          ),
          Text("$count ${widget.name}",
              style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: () {
              setState(() {
                count = count + 1;
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
