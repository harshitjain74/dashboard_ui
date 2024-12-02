import 'package:flutter/material.dart';

import '../../../../core/resources/colors.dart';

class StatsCards extends StatelessWidget{
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard(context, "29", "Jobs Applied",
              Colors.red, Icons.check_circle_outline_rounded),
          const SizedBox(width: 20),
          _buildStatCard(context, "3", "Interviews",
              AppColors.colorAccent, Icons.query_builder_rounded),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String count,
      String label, Color color, IconData icon) {

    return Expanded(
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(count,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -45, right: -40,
              child: Icon(icon, size: 180,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}