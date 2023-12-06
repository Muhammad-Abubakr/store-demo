import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    const backgroundColor = Colors.black;
    const foregroundColor = Colors.white;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
            child: Card(
              elevation: 0,
              color: backgroundColor,
              child: Padding(
                padding: EdgeInsets.all(0.03.sw),
                child:   Row(
                  children: [
                    CircleAvatar(radius: isLandscape ? 148.r : 90.r, backgroundColor: foregroundColor),
                    SizedBox(width: 42.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Abubakr Siddique", 
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: foregroundColor)),
                        Text("siddique.abubakr@yahoo.com", 
                        style: textTheme.bodySmall?.copyWith(color: foregroundColor)),
                        Text("03320397500", 
                        style: textTheme.bodySmall?.copyWith(color: foregroundColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.03.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => {}, 
                  icon: const Icon(Icons.settings_outlined), 
                  label: const Text("Kontoinstallningar"),
                ),
                TextButton.icon(
                  onPressed: () => {}, 
                  icon: const Icon(Icons.credit_card_outlined), 
                  label: const Text("Mina betalmetoder"),
                ),
                TextButton.icon(
                  onPressed: () => {}, 
                  icon: const Icon(Icons.support), 
                  label: const Text("Support"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}