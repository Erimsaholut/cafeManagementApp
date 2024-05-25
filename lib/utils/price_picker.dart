import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';

class PricePicker extends StatefulWidget {
  final String name;
  final int moneyValue;
  final int pennyValue;
  final int initialMoney;
  final int initialPenny;
  final Function(int, int) onValueChanged;

  const PricePicker({
    super.key,
    required this.name,
    this.moneyValue = 0,
    this.pennyValue = 0,
    this.initialMoney =15,
    this.initialPenny=0,
    required this.onValueChanged,
  });

  @override
  _PricePickerState createState() => _PricePickerState();
}

class _PricePickerState extends State<PricePicker> {
  late int _currentMoneyValue = widget.initialMoney;
  late int _currentPennyValue = widget.initialPenny;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        Text(widget.name, style: CustomTextStyles.blackAndBoldTextStyleL),



        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                NumberPicker(
                  value: _currentMoneyValue,
                  minValue: 0,
                  maxValue: 500,
                  step: 1,
                  haptics: true,
                  onChanged: (value) {
                    setState(() => _currentMoneyValue = value);
                    widget.onValueChanged(_currentMoneyValue, _currentPennyValue);
                  },
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
                  onChanged: (value) {
                    setState(() => _currentPennyValue = value);
                    widget.onValueChanged(_currentMoneyValue, _currentPennyValue);
                  },
                ),
              ],
            ),
          ],
        ),



        const SizedBox(height: 32,),
        Text('$_currentMoneyValue Lira $_currentPennyValue Kuruş'),
        const SizedBox(height: 32,),
      ],
    );
  }
}
