import 'package:flutter/material.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:my_skin_cancer_app/utils/constants/sizes.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }



  @override
  Widget build(BuildContext context) {
    final darkMode =isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: 0,
        backgroundColor: darkMode ? DColors.dark : Colors.white,
        indicatorColor: darkMode ? DColors.light.withOpacity(0.1) : DColors.dark.withOpacity(0.1),

        destinations:  [
          NavigationDestination(icon: Image.asset('assets/icons/home.png',height: DSizes.iconMd,), label: 'Home'),
          NavigationDestination(icon: Image.asset('assets/icons/user.png',height: DSizes.iconMd,), label: 'Profile'),


        ],),
    );;
  }
}






