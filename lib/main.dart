import 'package:demo/components/xtnd_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   setState(() {
    //     _isScrolled = _scrollController.offset > 150;
    //   });
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverAppBar with dynamic search icon
            DashboardAppBar(scrollController: _scrollController),

            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Gradient and Search Bar
                  HeaderView(),
                  SizedBox(height: 20),

                  // Stats Cards
                  StatsCards(),
                  SizedBox(height: 20),

                  // Recommended Jobs Section
                  RecommendedJobs(),
                  SizedBox(height: 20),

                  // Recent Jobs Section
                  RecentJobs(),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}