import 'package:flutter/material.dart';

import 'home_customer.dart';
import 'favorite_page.dart';
import 'cart_page.dart';
import 'riwayat_page.dart';
import 'profile_page.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() =>
      _HomeNavigationState();
}

class _HomeNavigationState
    extends State<HomeNavigation> {

  int selectedIndex = 0;

  final List<Widget> pages = [

    const HomeCustomer(),

    const FavoritePage(),

    const CartPage(),

    const RiwayatPage(),

    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(

        index: selectedIndex,

        children: pages,
      ),

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: selectedIndex,

        selectedItemColor:
            const Color(0xff5EDAE5),

        unselectedItemColor:
            Colors.grey,

        type:
            BottomNavigationBarType.fixed,

        showSelectedLabels: false,

        showUnselectedLabels: false,

        onTap: (index) {

          setState(() {

            selectedIndex = index;

          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}