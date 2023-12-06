import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../contants.dart' as constants;

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* App Bar */
      appBar: AppBar(
        title: Text(
          constants.pages[pageIdx].first,
          style: TextStyle(fontSize: 24.spMax, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /* `pages` from constants mapped to `pageIdx` which is set by bottom navigation bar */
      body: constants.pages[pageIdx].last,

      /* Bottom Navigation Bar */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIdx,
        onTap: (value) => setState(() => pageIdx = value),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Mitt Konto",
          )
        ],
      ),
    );
  }
}
