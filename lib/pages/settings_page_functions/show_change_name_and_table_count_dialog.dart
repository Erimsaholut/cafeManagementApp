import 'package:flutter/material.dart';

import '../../datas/write_data.dart';

class ChangeTableCountDialog extends StatefulWidget {
  final String mainTitle;
  final String textFieldTitle;

  ChangeTableCountDialog({
    required this.mainTitle,
    required this.textFieldTitle,
  });

  @override
  _ChangeTableCountDialogState createState() => _ChangeTableCountDialogState();
}

class _ChangeTableCountDialogState extends State<ChangeTableCountDialog> {
  WriteData writeData = WriteData();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.mainTitle),
      content: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.textFieldTitle,
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
            bool updateMasaSayisi =
                _controller.text.isNotEmpty &&
                    RegExp(r'^[0-9]+$').hasMatch(_controller.text);

            if (updateMasaSayisi) {
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
                          setState(() {
                            int tableCount = int.parse(_controller.text);
                            writeData.setTableCount(tableCount);
                            print("data.tableCount = masaSayisi; calisti");
                            _controller.clear();
                          });
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
                        'Masa sayısı güncellemek için geçerli bir değer girin.'),
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

class ChangeCafeNameDialog extends StatefulWidget {
  final String mainTitle;
  final String textFieldTitle;

  ChangeCafeNameDialog({
    required this.mainTitle,
    required this.textFieldTitle,
  });

  @override
  _ChangeCafeNameDialogState createState() => _ChangeCafeNameDialogState();
}

class _ChangeCafeNameDialogState extends State<ChangeCafeNameDialog> {
  WriteData writeData = WriteData();
  final TextEditingController _controller = TextEditingController();

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

            if (updateName) {
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
                          setState(() {
                            writeData.setCafeName(_controller.text);
                            print("data.cafeName = _controller.text; calisti");
                            _controller.clear();
                          });
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
                    content: const Text('İsim güncellemek için bir değer girin.'),
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
