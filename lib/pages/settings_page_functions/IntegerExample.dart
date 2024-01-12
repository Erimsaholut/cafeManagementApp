import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
class IntegerExample extends StatefulWidget {
  final String name;

  IntegerExample({required this.name});

  @override
  _IntegerExampleState createState() => _IntegerExampleState();
}

class _IntegerExampleState extends State<IntegerExample> {
  int _currentMoneyValue = 15;
  int _currentPennyValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        Text(widget.name, style: Theme.of(context).textTheme.titleLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                NumberPicker(
                  value: _currentMoneyValue,
                  minValue: 0,
                  maxValue: 300,
                  step: 1,
                  haptics: true,
                  onChanged: (value) =>
                      setState(() => _currentMoneyValue = value),
                ),
              ],
            ),
            Column(
              children: [
                NumberPicker(
                  value: _currentPennyValue,
                  minValue: 0,
                  maxValue: 75,
                  step: 25,
                  haptics: true,
                  onChanged: (value) =>
                      setState(() => _currentPennyValue = value),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('$_currentMoneyValue Lira $_currentPennyValue Kuruş'),
        const SizedBox(height: 32),
      ],
    );
  }
}

