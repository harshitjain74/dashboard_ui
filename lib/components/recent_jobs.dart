import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/config.dart';

class RecentJobs extends StatelessWidget{
  const RecentJobs({super.key});

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
                "Recent Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("More"),
              ),
            ],
          ),
        ),

        // Job List
        _buildRecentJobTile(context, "Junior Software Engineer", "Highspeed Studios", "Jakarta, Indonesia"),
        _buildRecentJobTile(context, "Database Engineer", "Lunar Djaja Corp.", "London, UK"),
        _buildRecentJobTile(context, "Senior Software Engineer", "Darkseer Studios", "New York, USA"),
      ],
    );
  }

  Widget _buildRecentJobTile(BuildContext context,String title, String company, String location) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.colorAccentDark, // Border color
            width: 0.2,        // Border thickness
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // child: Image.network(
            child: SvgPicture.asset(R.icon.jobsLogo,
                width: 45,
                height: 45,
                // colorFilter: ColorFilter.mode(
                //     AppColors.black87, BlendMode.srcIn),
                semanticsLabel: title),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 5),
                Text(title, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 2),
                _getIconLabel(context, "\$500 - \$1,000", Icons.price_change_outlined),
                _getIconLabel(context, location, Icons.eight_mp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconLabel(BuildContext context, String label, IconData icon){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                icon,
                size: 18,
                // color: 24,
              ),
            ),
            const WidgetSpan(child: SizedBox(width: 8)), // Space between icon and text
            TextSpan(
              text: label,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}