import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/aylikVeriYapici.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  List<double> valueList = [];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // listSeparator fonksiyonunu çağırıp sonucu değer listesine atıyoruz
    _loadValueList();
  }

  // Değer listesini dolduran fonksiyon
  Future<void> _loadValueList() async {
    valueList = await listSeparator();
    setState(() {}); // Widget'ın yeniden çizilmesi için setState kullanıyoruz
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      _pageViewController.jumpToPage(_tabController.index);
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
            child: PageView(
              controller: _pageViewController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                  _tabController.animateTo(index);
                });
              },
              children: <Widget>[
                Column(
                  children: [
                    Container(child: CustomMonthlyChart(valueList: valueList),)
                  ],
                ),
                Column(
                  children: [
                  ],
                ),
                Column(
                  children: [
                    Container(color: Colors.red, child: PieChartSample2())
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
                _pageViewController.animateToPage(
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

Future<List<double>> listSeparator() async {
  AnalysesReader analysesReader = AnalysesReader();
  List<double> valueList = [];
  DateTime now = DateTime.now();
  Map<String, double>? monthlySales = await analysesReader.getDailyTotalRevenueForMonth(now.month, now.year);
  valueList = monthlySales.values.toList();

  return valueList;
}
