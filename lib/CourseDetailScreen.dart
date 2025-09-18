import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CourseDetailScreen extends StatefulWidget {
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Course 1"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.cyanAccent,
          tabs: const [Tab(text: "Detail Course"), Tab(text: "Aktivitas")],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [_buildCourseDetail(), _buildUserActivity()],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Mulai Belajar"),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: Colors.cyanAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCourseDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
              ),
            ),
            child: Center(
              child: Text(
                "Course 1: UI Futuristik",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Progress
          Text(
            "Progress Belajar",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.35,
            backgroundColor: Colors.white12,
            color: Colors.cyanAccent,
            minHeight: 8,
          ),
          const SizedBox(height: 20),

          // Modul List
          Text(
            "Daftar Modul",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          ...List.generate(5, (i) {
            return Card(
              color: Colors.white10,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: Icon(Icons.play_circle_fill, color: Colors.cyanAccent),
                title: Text(
                  "Modul ${i + 1} - Topik ${i + 1}",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${20 + i * 5} menit",
                  style: TextStyle(color: Colors.white54),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.white70),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUserActivity() {
    // Data untuk grafik
    final List<_ActivityData> weeklyActivity = [
      _ActivityData('S', 2),
      _ActivityData('M', 4),
      _ActivityData('T', 3),
      _ActivityData('W', 5),
      _ActivityData('T', 6),
      _ActivityData('F', 4),
      _ActivityData('S', 7),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=12",
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hi, User!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "Tetap semangat belajar 🚀",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Statistik
          Text(
            "Statistik",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatCard(title: "Jam", value: "12"),
              _StatCard(title: "Modul", value: "8/12"),
              _StatCard(title: "Badge", value: "3"),
            ],
          ),
          const SizedBox(height: 24),

          // Grafik Aktivitas dengan Syncfusion
          Text(
            "Aktivitas Mingguan",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),

          // Grafik Aktivitas dengan Syncfusion
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(color: Colors.white70),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 10,
                interval: 2,
                labelStyle: TextStyle(color: Colors.white70),
              ),
              series: <CartesianSeries<_ActivityData, String>>[
                ColumnSeries<_ActivityData, String>(
                  dataSource: weeklyActivity,
                  xValueMapper: (_ActivityData data, _) => data.day,
                  yValueMapper: (_ActivityData data, _) => data.hours,
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(6),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Rekomendasi modul
          Text(
            "Rekomendasi Selanjutnya",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.auto_awesome,
                color: Colors.purpleAccent,
                size: 36,
              ),
              title: Text(
                "Modul 9 - Deep Animations",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Level lanjutan, AI rekomendasikan untukmu",
                style: TextStyle(color: Colors.white54),
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                ),
                child: const Text("Mulai"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityData {
  final String day;
  final double hours;
  _ActivityData(this.day, this.hours);
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
