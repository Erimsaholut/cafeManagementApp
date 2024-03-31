import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:flutter/cupertino.dart';
import '../utils/analysesWidgets/custom_line_chart.dart';
import '../utils/analysesWidgets/custom_pie_graph.dart';
import '../constants/custom_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  }) : super(key: key);

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.appbarColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              splashRadius: 16.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (currentPageIndex == 0) return;
                onUpdateCurrentPageIndex(currentPageIndex - 1);
              },
              icon: const Icon(
                Icons.arrow_left_rounded,
                size: 32.0,
              ),
            ),
            TabPageSelector(
              controller: tabController,
              color: Colors.white,
              selectedColor: CustomColors.selectedColor2,
            ),
            IconButton(
              splashRadius: 16.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (currentPageIndex == 2) return;
                onUpdateCurrentPageIndex(currentPageIndex + 1);
              },
              icon: const Icon(
                Icons.arrow_right_rounded,
                size: 32.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({Key? key}) : super(key: key);

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  List<double> monthlyRevenueValues = [];
  List<double> weeklyRevenueValues = [];
  Map<int, Map<String, int>> monthlyItemValues = {};
  List<String> months = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık",
  ];
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    _loadRevenueValues();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      _pageController.jumpToPage(_tabController.index);
    }
  }

  Future<void> _loadRevenueValues() async {
    try {
      // Paralel istekler yapılıyor
      final monthlyFuture = fetchMonthlyRevenueValues();
      final weeklyFuture = fetchWeeklyRevenueValues();
      final monthlyItem = fetchMonthlyItemValues();

      // Veriler beklendiği gibi alınıyor
      monthlyRevenueValues = await monthlyFuture;
      weeklyRevenueValues = await weeklyFuture;
      monthlyItemValues = (await monthlyItem)!;
    } catch (error) {
      // Hata durumunda kullanıcıya bilgi vermek için uygun bir geri bildirim sağlanabilir
      print("Hata oluştu: $error");
      // Hata durumunda verileri sıfırlayabilir veya varsayılan bir değer atayabilirsiniz
      monthlyRevenueValues = [];
      weeklyRevenueValues = [];
      monthlyItemValues = {};
    } finally {
      // setState çağrısı veri yüklendikten sonra yapılıyor
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.appbarColor,
        title: const Text('Analyses'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: monthlyRevenueValues.isEmpty
                ? const Center(
              child:
              CircularProgressIndicator(), // veya uygun bir yüklenme göstergesi
            )
                : PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                  _tabController.animateTo(index);
                });
              },
              children: <Widget>[
                Column(
                  children: [
                    /**/
                    Text("${months[now.month - 1]} ayının günlük gelir analizleri ",style: CustomTextStyles.blackAndBoldTextStyleM,),
                    Expanded(
                      child: CustomLineChart(
                          valueList: monthlyRevenueValues),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("${months[now.month - 1]} ayının haftalar halinde gelir analizleri",style: CustomTextStyles.blackAndBoldTextStyleM,),
                    Expanded(
                      child:
                      CustomLineChart(valueList: weeklyRevenueValues),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("${months[now.month - 1]} ayının ürün satış miktar verileri",style: CustomTextStyles.blackAndBoldTextStyleM,),
                    Expanded(
                      child: CustomPieChart(
                        itemList: monthlyItemValues,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: PageIndicator(
              tabController: _tabController,
              currentPageIndex: _currentPageIndex,
              onUpdateCurrentPageIndex: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              isOnDesktopAndWeb: true,
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<double>> fetchMonthlyRevenueValues() async {
  AnalysesReader analysesReader = AnalysesReader();
  DateTime now = DateTime.now();
  Map<String, double>? monthlySales =
  await analysesReader.getDailyTotalRevenueForMonth(now.month, now.year);
  List<double> revenueValues = monthlySales.values.toList();
  return revenueValues;
}

Future<List<double>> fetchWeeklyRevenueValues() async {
  AnalysesReader analysesReader = AnalysesReader();
  DateTime now = DateTime.now();
  Map<String, double>? weeklySales =
  await analysesReader.getWeeklyTotalRevenueForMonth(now.month, now.year);
  List<double> revenueValues = weeklySales.values.toList();
  print("revenueValues:$revenueValues");
  return revenueValues;
}

Future<Map<int, Map<String, int>>?> fetchMonthlyItemValues() async {
  AnalysesReader analysesReader = AnalysesReader();
  DateTime now = DateTime.now();

  Map<int, Map<String, int>>? monthlySales =
  await analysesReader.getWeeklyProductSalesForMonth(now.month, now.year);
  print("revenueValues:$monthlySales");
  return monthlySales;
}

//todo belki yıllık özellik gelebilir hatta anlık olarak yıllık ve aylık da yazsa güzel olur yıllık çekince 1000 satır kod çalışıyor anlık amk
