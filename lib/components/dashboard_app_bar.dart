import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/config.dart';

class DashboardAppBar extends StatefulWidget{
  const DashboardAppBar({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  bool _isScrolled = false;

  // Function to scroll to the search bar
  void _scrollToSearch() {
    widget.scrollController.animateTo(
      widget.scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      setState(() {
        _isScrolled = widget.scrollController.offset > 150;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      elevation: 0,
      // leading: Icon(Icons.menu),
      actions: [
        if (_isScrolled)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _scrollToSearch,
          ),

        if (_isScrolled)
          CircleAvatar(
            radius: 12,
            // backgroundImage: imageBytes != null
            //     ? MemoryImage(imageBytes) // Show the image if decoding succeeds
            //     : null, // No background image if there's an error
            child: SvgPicture.asset(R.icon.profileIcon,
                width: 16,
                height: 16,
                semanticsLabel: 'User'),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: _isScrolled
            ? const Text(
          'Good Morning\nNaveen Singh',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.textDark),
        ) : null,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
        background: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.beginColor, AppColors.endColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: const SizedBox(height: 155, width: double.infinity,),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Naveen Singh',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: CircleAvatar(
                          radius: 24,
                          // backgroundImage: imageBytes != null
                          //     ? MemoryImage(imageBytes) // Show the image if decoding succeeds
                          //     : null, // No background image if there's an error
                          child: /*imageBytes == null
                              ?*/ SvgPicture.asset(R.icon.profileIcon,
                              width: 34,
                              height: 34,
                              semanticsLabel: 'User')/* : null*/,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Search bar only visible when not scrolled
                  if (!_isScrolled)
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search job here...',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}