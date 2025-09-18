import 'package:flutter/material.dart';
import 'package:online_course/models/SalesData.dart';
import '../../models/app_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({Key? key}) : super(key: key);

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  var vendorId = 1;
  var orders = 0;
  var availableFunds = 0.0;
  var products = 0;

  Future<void> fetchData() async {
    // Dummy data seolah-olah dari Firestore
    final dummyData = [
      {
        'vendorId': '123',
        'isDelivered': false,
        'prodPrice': 50000,
        'prodQuantity': 2,
      },
      {
        'vendorId': '123',
        'isDelivered': true,
        'prodPrice': 75000,
        'prodQuantity': 1,
      },
      {
        'vendorId': '123',
        'isDelivered': false,
        'prodPrice': 20000,
        'prodQuantity': 5,
      },
    ];

    int newOrdersCount = dummyData.length;
    double newAvailableFunds = 0.0;

    for (var doc in dummyData) {
      final bool delivered = (doc['isDelivered'] ?? true) as bool;
      if (!delivered) {
        final num price = (doc['prodPrice'] ?? 0) as num;
        final num quantity = (doc['prodQuantity'] ?? 0) as num;
        newAvailableFunds += price.toDouble() * quantity.toDouble();
      }
    }

    setState(() {
      orders = newOrdersCount;
      availableFunds = newAvailableFunds;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<AppData> data = [
      AppData(
        title: 'All Orders',
        number: orders,
        color: Colors.blue,
        icon: Icons.shopping_cart_checkout,
        index: 1,
      ),
      AppData(
        title: 'Available Funds',
        number: availableFunds,
        color: Colors.grey,
        icon: Icons.monetization_on,
        index: 3,
      ),
      AppData(
        title: 'Products',
        number: products,
        color: Colors.red,
        icon: Icons.shopping_bag,
        index: 2,
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.purpleAccent,
        onRefresh: () => fetchData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              right: 0,
              left: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [VendorWelcomeIntro(), VendorLogoutAc()],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6.5,
                  child: ListView.builder(
                    itemCount: data.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return BuildDashboardContainer(
                        title: item.title,
                        value:
                            item.index == 3
                                ? '\$${item.number}'
                                : item.number.toString(),
                        color: item.color,
                        icon: item.icon,
                        index: item.index,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your store analysis',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                VendorDataGraph(data: data),
                SizedBox(height: 20),
                BarChartExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------- //
// Widgets langsung di sini  //
// -------------------------- //

class BuildDashboardContainer extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final int index;

  const BuildDashboardContainer({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class VendorDataGraph extends StatelessWidget {
  final List<AppData> data;
  const VendorDataGraph({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'ShoesShop Analysis for app data'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<AppData, String>>[
          LineSeries<AppData, String>(
            dataSource:
                data.isEmpty
                    ? [
                      AppData(
                        title: "Dummy A",
                        number: 10,
                        color: Colors.blue,
                        icon: Icons.shopping_cart,
                        index: 1,
                      ),
                      AppData(
                        title: "Dummy B",
                        number: 20,
                        color: Colors.red,
                        icon: Icons.shopping_cart,
                        index: 2,
                      ),
                    ]
                    : data,
            xValueMapper: (AppData sales, _) => sales.title,
            yValueMapper: (AppData sales, _) => sales.number.toDouble(),
            name: 'Numbers',
            color: Colors.blue, // biar jelas
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class VendorWelcomeIntro extends StatelessWidget {
  const VendorWelcomeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome Vendor 👋",
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}

class VendorLogoutAc extends StatelessWidget {
  const VendorLogoutAc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.black.withOpacity(0.3),
      ),
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.red),
        onPressed: () {
          // nanti isi action logout di sini
          Navigator.pop(context);
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(const SnackBar(content: Text("Logout tapped")));
        },
      ),
    );
  }
}

class BarChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(), // Or DateTimeAxis, NumericAxis
        series: <BarSeries<SalesData, String>>[
          BarSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Jan', 35, 2023),
              SalesData('Feb', 28, 2024),
              SalesData('Mar', 34, 2024),
              SalesData('Apr', 32, 2025),
              SalesData('May', 40, 2026),
            ],
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}
