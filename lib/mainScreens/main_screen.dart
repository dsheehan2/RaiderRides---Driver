import 'package:driver_app/tabPages/earning_tab.dart';
import 'package:driver_app/tabPages/home_tab.dart';
import 'package:driver_app/tabPages/profile_tab.dart';
import 'package:flutter/material.dart';

import '../tabPages/ratings_tab.dart';

class MainScreen extends StatefulWidget
{

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedIndex = 0;

  // Color bottomNavBarColor = Color(0xFFD72620); -> Use later

  onItemClicked(int index)
  {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Earnings",
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Ratings",
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
          ),

        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFFD72620),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
