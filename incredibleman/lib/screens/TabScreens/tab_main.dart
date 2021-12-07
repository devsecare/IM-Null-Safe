import 'package:flutter/material.dart';
import 'package:incredibleman/constants/constants.dart';
import 'package:incredibleman/screens/Home/home.dart';
import 'package:incredibleman/screens/TabScreens/order_list_screen.dart';

import 'account_screen.dart';
import 'im_combo_screen.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget icon;
  final Widget activeIcon;

  TabNavigationItem(
      {required this.page,
      required this.title,
      required this.icon,
      required this.activeIcon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: const HomeScreen(),
          title: 'Home',
          icon: Image.asset(
            hometab,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            homeSelected,
            scale: 2.5,
          ),
        ),
        TabNavigationItem(
          page: const ImcomboScreen(),
          title: 'IM Combo',
          icon: Image.asset(
            im,
            scale: 5,
          ),
          activeIcon: Image.asset(
            imtabse,
            scale: 5,
          ),
        ),
        TabNavigationItem(
          page: const OrderListScreen(),
          title: 'Orders',
          icon: Image.asset(
            order,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            orderSelected,
            scale: 2.5,
          ),
        ),
        TabNavigationItem(
          page: const Account(),
          title: 'Account',
          icon: Image.asset(
            account,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            accountSelected,
            scale: 2.5,
          ),
        ),
      ];
}
