import 'package:adisso/constants/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  bool loadExampleMenu = true;
  int _currentPage = 0;

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
                // Page 1
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tols Kasa Yönetim\nSistemine Hoşgeldiniz",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Başlamadan önce tamamlamamız gereken birkaç adım var ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                // Page 2
                Container(
                  color: Colors.orange,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tols Kasa Yönetim sistemi ile:\n",
                          style: CustomTextStyles.blackAndBoldTextStyleXl,
                        ),
                        Text(
                          "Masaların ve müşterilerin hesabını tutabilir",
                          style: CustomTextStyles.blackAndBoldTextStyleM,
                        ),
                        Text(
                          "Toplam satış miktarınızı, brüt ve net karınızı hesaplayabilir",
                          style: CustomTextStyles.blackAndBoldTextStyleM,
                        ),
                        Text(
                          "Ve analiz özelliğikleri sayesinde istediğiniz zaman dilimlerini takip edip karşılaştırabilirsiniz.",
                          style: CustomTextStyles.blackAndBoldTextStyleM,
                        ),
                      ],
                    ),
                  ),
                ),
                // Page 3
                Container(
                  color: Colors.green,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Başlamadan önce birkaç özelleştirme yapalım\n",
                            style: CustomTextStyles.blackAndBoldTextStyleL,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenSize.width / 3,
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Kafe İsmi',
                                  hintText: 'Kafe İsmini Giriniz',
                                ),
                                maxLength: 50,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('cafeName', value);
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
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (value) async {
                                  if (int.tryParse(value) != null) {
                                    int enteredValue = int.parse(value);
                                    if (enteredValue > 0) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setInt(
                                          'tableCount', enteredValue);
                                      int? tableCount =
                                          prefs.getInt('tableCount');
                                      print(tableCount);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Masa sayısı 0'dan büyük olmalıdır."),
                                      ));
                                    }
                                  }
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
                                    onChanged: (value) async {
                                      setState(() {
                                        loadExampleMenu = value!;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool(
                                          'loadExampleMenu', loadExampleMenu);
                                      print("loadExampleMenu");
                                      print(prefs.getBool('loadExampleMenu'));
                                      if (value == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Örnek menü uygulmanın temel özelliklerini görebileceğiniz ürünler ekler. İlk kullanım için tavsiye edilir.",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const Text('Örnek menü yüklensin mi ?'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Girdiğiniz değerleri ve menüyü daha sonra \"Ayarlar\" bölümünden güncelleştirebilirsiniz.",
                              style: CustomTextStyles.blackTextStyleS,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Page 4
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "Tols Kasa Yönetim sistemini 30 gün boyunca ücretsiz kullanabilirisiniz.\n",
                                    style: CustomTextStyles
                                        .blackAndBoldTextStyleL),
                                Text(
                                    "Deneme sürümüne örnek menü hariç 15 ürün ekleyebilirsiniz.",
                                    style: CustomTextStyles
                                        .blackAndBoldTextStyleL),
                                Text(
                                    "Uygulamayı ürün ekleme sınırı olmadan kullanmak için ana menüdeki butonları kullanabilirsiniz.",
                                    style: CustomTextStyles
                                        .blackAndBoldTextStyleL),
                              ]),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.getInt('tableCount') != null &&
                                      prefs.getString('cafeName') != null) {
                                    await prefs.setInt('isOpenedBefore', 1);
                                    print(prefs.getInt('isOpenedBefore'));

                                    final DateTime now = DateTime.now();
                                    await prefs.setInt('firstOpenDay', now.day);
                                    await prefs.setInt(
                                        'firstOpenMonth', now.month);
                                    await prefs.setInt(
                                        'firstOpenYear', now.year);

                                    print(
                                        "${prefs.getInt('firstOpenDay')}${prefs.getInt('firstOpenMonth')}${prefs.getInt('firstOpenYear')}");

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NormalApp(
                                          cafeName:
                                              prefs.getString('cafeName') ??
                                                  'Default Cafe',
                                          tableCount:
                                              prefs.getInt('tableCount') ?? 10,
                                          dayDifference: 30,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print(
                                        "${prefs.getInt('tableCount')} ${prefs.getString('cafeName')}");
                                    String problem = "";
                                    if (prefs.getString('cafeName') == null) {
                                      problem = "Kafe ismi";
                                    } else {
                                      problem = "Masa sayısı";
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('$problem değeri boş olamaz'),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      return Colors.white.withOpacity(0.9);
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8.0), // İsteğe bağlı: Köşeleri yuvarlaklaştırabilirsiniz
                                      );
                                    },
                                  ),
                                ),
                                child: Text(
                                  "Deneme üyeliğimi başlat !",
                                  style:
                                      CustomTextStyles.blackAndBoldTextStyleM,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Page indicator
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(4, (int index) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                    color: _currentPage == index ? Colors.white : Colors.black,
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
