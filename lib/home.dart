import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Auto-scroll Recommended Jobs
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % 3; // Total cards = 3
        });
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Gradient and Search Bar
            _buildHeader(),
            SizedBox(height: 20),

            // Stats Cards
            _buildStatsCards(),
            SizedBox(height: 20),

            // Recommended Jobs Section
            _buildRecommendedJobs(),
            SizedBox(height: 20),

            // Recent Jobs Section
            _buildRecentJobs(),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5364F0), Color(0xFF2939C8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and Profile Picture
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Good Morning\nNaveen Singh",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'), // Replace with actual image
                radius: 25,
              ),
            ],
          ),
          SizedBox(height: 20),

          // Search Bar
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search job here...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard("29", "Jobs Applied", Colors.red, Icons.check_circle),
          _buildStatCard("3", "Interviews", Colors.blue, Icons.question_mark),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color color, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color.withOpacity(0.1),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Recommended Jobs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        // Horizontal Scrollable Cards
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3, // Replace with dynamic count
            itemBuilder: (context, index) {
              return _buildRecommendedJobCard();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedJobCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.work, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text("Software Engineer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Jakarta, Indonesia"),
            Spacer(),
            Text("\$500 - \$1,000", style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text("More"),
              ),
            ],
          ),
        ),

        // Job List
        _buildRecentJobTile("Junior Software Engineer", "Highspeed Studios", "Jakarta, Indonesia"),
        _buildRecentJobTile("Database Engineer", "Lunar Djaja Corp.", "London, UK"),
        _buildRecentJobTile("Senior Software Engineer", "Darkseer Studios", "New York, USA"),
      ],
    );
  }

  Widget _buildRecentJobTile(String title, String company, String location) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(Icons.work, color: Colors.black),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("$company\n$location"),
      isThreeLine: true,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      currentIndex: 0,
      onTap: (index) {},
    );
  }
}
