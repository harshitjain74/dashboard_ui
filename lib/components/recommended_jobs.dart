import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/config/config.dart';

class RecommendedJobs extends StatefulWidget{
  const RecommendedJobs({super.key});

  @override
  State<RecommendedJobs> createState() => _RecommendedJobsState();
}

class _RecommendedJobsState extends State<RecommendedJobs> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
// Auto-scroll logic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
    // // Auto-scroll Recommended Jobs
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    //   if (_pageController.hasClients) {
    //     setState(() {
    //       _currentPage = (_currentPage + 1) % 3; // Total cards = 3
    //     });
    //     _pageController.animateToPage(
    //       _currentPage,
    //       duration: const Duration(milliseconds: 500),
    //       curve: Curves.easeInOut,
    //     );
    //   }
    // });
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
        });
        _autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recommended Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 8,
                    width: _currentPage == index ? 16 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.colorAccentDark : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Horizontal Scrollable Cards
        SizedBox(
          height: 130,
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
      margin: const EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: Image.network(
              child: Image.asset(
                R.images.rjLogo,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Software Engineer", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 2),
                  Text("Jakarta, Indonesia"),
                  SizedBox(height: 4),
                  Text("\$500 - \$1,000", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}