import 'package:flutter/material.dart';
import '../datas/menu_data/read_data.dart';

class EditItems extends StatelessWidget {
  EditItems({super.key});
  ReadData readData = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Items"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: readData.getRawData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // or any loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data?['menu'] == null) {
              return Text('No data available.');
            } else {
              List<dynamic> menuItems = snapshot.data!['menu'];

              return GridView.count(
                crossAxisCount: 4, // Set the number of columns
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: menuItems.map((item) {
                  return TextButton(
                    onPressed: () {

                      print(item['name']);
                      
                    },
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return null; // Use the default value.
                        },
                      ),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(item['name']),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
