import 'package:flutter/material.dart';

class AnimatedHomeScreen extends StatefulWidget {
  const AnimatedHomeScreen({super.key});

  @override
  State<AnimatedHomeScreen> createState() => _AnimatedHomeScreenState();
}

class _AnimatedHomeScreenState extends State<AnimatedHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar and Greeting Section
                FadeTransition(
                  opacity: _controller,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOut,
                    )),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Naveen Singh",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/50', // Replace with user image
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Search Box
                FadeTransition(
                  opacity: _controller,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "Search job here...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Jobs Applied and Interviews
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeOut,
                  )),
                  child: Row(
                    children: [
                      _buildSummaryCard(
                        color: Colors.redAccent,
                        title: "29",
                        subtitle: "Jobs Applied",
                        icon: Icons.check_circle_outline,
                      ),
                      const SizedBox(width: 16),
                      _buildSummaryCard(
                        color: Colors.blueAccent,
                        title: "3",
                        subtitle: "Interviews",
                        icon: Icons.question_mark,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Recommended Jobs Section
                FadeTransition(
                  opacity: _controller,
                  child: const Text(
                    "Recommended Jobs",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: Interval(
                              0.2 * index,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                        child: _buildRecommendedJobCard(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Recent Jobs Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeTransition(
                      opacity: _controller,
                      child: const Text(
                        "Recent Jobs",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("More"),
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // Recent Job Tiles with Animation
                Column(
                  children: List.generate(
                    3,
                        (index) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            0.2 * index,
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ),
                      ),
                      child: _buildRecentJobTile(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      {required Color color,
        required String title,
        required String subtitle,
        required IconData icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedJobCard() {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey,
            child: Icon(Icons.work, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Software Engineer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text("\$500 - \$1,000",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRecentJobTile() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.work, color: Colors.white),
      ),
      title: const Text(
        "Junior Software Engineer",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\$500 - \$1,000", style: TextStyle(color: Colors.grey)),
          Text("Jakarta, Indonesia", style: TextStyle(color: Colors.grey)),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      isThreeLine: true,
    );
  }
}