import 'package:flutter/material.dart';

import '../datas/write_data.dart';

//todo baş ve son için trim atabilir.

class ChangeNameDialog extends StatefulWidget {
  final String mainTitle;
  final String textFieldTitle;
  final String secondTextFieldTitle;

  ChangeNameDialog({
    required this.mainTitle,
    required this.textFieldTitle,
    required this.secondTextFieldTitle,
  });

  @override
  _ChangeNameDialogState createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  WriteData writeData = WriteData();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.mainTitle),
      content: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.textFieldTitle,
            ),
          ),
          TextField(
            controller: _secondController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.secondTextFieldTitle,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('İptal'),
        ),
        TextButton(
          onPressed: () async {
            bool updateName = _controller.text.isNotEmpty;
            bool updateMasaSayisi = _secondController.text.isNotEmpty &&
                RegExp(r'^[0-9]+$').hasMatch(_secondController.text);

            if (updateName || updateMasaSayisi) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Emin misiniz?'),
                    content: const Text(
                        'Değişiklikleri kaydetmek istediğinizden emin misiniz?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hayır'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (updateName) {
                            setState(() {
                              writeData.setCafeName(_controller.text);
                              print("data.cafeName = _controller.text; calisti");
                            });
                            _controller.clear();
                          }

                          if (updateMasaSayisi) {
                            setState(() {
                              int tableCount = int.parse(_secondController.text);
                              writeData.setTableCount(tableCount);
                              print("data.tableCount = masaSayisi; calisti");
                              _secondController.clear();
                            });
                          }

                          Navigator.of(context).pop();
                        },
                        child: const Text('Evet'),
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Uyarı'),
                    content: const Text(
                        'En az bir değeri güncellemek için bir bilgi girin.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tamam'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
