import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:flutter/widgets.dart';
import '../utils/custom_line_chart.dart';
import '../utils/test_graph2.dart';

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
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Colors.amber.withOpacity(0.6),
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
              color: colorScheme.background,
              selectedColor: colorScheme.primary,
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

class _AnalysesPageState extends State<AnalysesPage> with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  List<double> monthlyRevenueValues = [];
  List<double> weeklyRevenueValues = [];

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

      // Veriler beklendiği gibi alınıyor
      monthlyRevenueValues = await monthlyFuture;
      weeklyRevenueValues = await weeklyFuture;
    } catch (error) {
      // Hata durumunda kullanıcıya bilgi vermek için uygun bir geri bildirim sağlanabilir
      print("Hata oluştu: $error");
      // Hata durumunda verileri sıfırlayabilir veya varsayılan bir değer atayabilirsiniz
      monthlyRevenueValues = [];
      weeklyRevenueValues = [];
    } finally {
      // setState çağrısı veri yüklendikten sonra yapılıyor
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.withOpacity(0.6),
        title: const Text('Analyses'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: monthlyRevenueValues.isEmpty
                ? Center(
              child: CircularProgressIndicator(), // veya uygun bir yüklenme göstergesi
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
                    Expanded(
                      child: CustomLineChart(valueList: monthlyRevenueValues),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: CustomLineChart(valueList: weeklyRevenueValues),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: const PieChartSample2(),
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
  Map<String, double>? monthlySales = await analysesReader.getDailyTotalRevenueForMonth(now.month, now.year);
  List<double> revenueValues = monthlySales.values.toList() ?? [];
  return revenueValues;
}

Future<List<double>> fetchWeeklyRevenueValues() async {
  AnalysesReader analysesReader = AnalysesReader();
  DateTime now = DateTime.now();
  Map<String, double>? weeklySales = await analysesReader.getWeeklyTotalRevenueForMonth(now.month, now.year);
  List<double> revenueValues = weeklySales.values.toList() ?? [];
  print("revenueValues:$revenueValues");
  return revenueValues;
}
//todo baştaki hata muhabbetini çöz ve ekrana hizalamasını düzgün yap