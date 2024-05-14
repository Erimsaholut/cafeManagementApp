import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  String cafeName = '';
  String tableCount = '';
  bool loadExampleMenu = true; // Checkbox'un başlangıçta seçili gelmesi için true yapıldı.

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                // Sayfa 1
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tols Kasa Yönetim\nSistemine Hoşgeldiniz",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Başlamadan önce uygulamayı sizin için özelleştirelim ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                // Sayfa 2
                Container(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenSize.width / 3,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Kafe İsmi',
                            hintText: 'Kafe İsmini Giriniz',
                          ),
                          maxLength: 50, // Maksimum karakter sayısı
                          onChanged: (value) {
                            setState(() {
                              cafeName = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 3,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Masa Sayısı',
                            hintText: 'Masa Sayısını Giriniz',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              tableCount = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: loadExampleMenu,
                              onChanged: (value) {
                                setState(() {
                                  loadExampleMenu = value!;
                                });
                              },
                            ),
                            const Text('Örnek menü yüklensin mi'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Sayfa 3
                Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Page 3"),
                        // Buraya fonksiyonellik eklenebilir
                      ],
                    ),
                  ),
                ),
                // Sayfa 4
                Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text("Page 4"),
                  ),
                ),
              ],
            ),
          ),
          // Sayfa indikatörü
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(4, (int index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black),
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
