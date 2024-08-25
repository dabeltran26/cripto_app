import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/favorites/presentation/views/favorite_view.dart';
import 'package:cripto_app/home/presentation/views/home_view.dart';
import 'package:cripto_app/utils/images.dart';
import 'package:flutter/material.dart';

import 'profile/presentation/views/profile_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> navigatorScreens = [const HomeView(), const FavoriteView(), const ProfileView()];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsApp.white,
        currentIndex: tabController.index,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold).copyWith(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal).copyWith(fontSize: 14),
        onTap: (index) {
          setState(() {
            tabController.index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorsApp.black60,
        selectedItemColor: ColorsApp.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                Images.homeIcon,
                color: tabController.index == 0 ? ColorsApp.primaryColor : ColorsApp.black60,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                Images.favoritesIcon,
                color: tabController.index == 1 ? ColorsApp.primaryColor : ColorsApp.black60,
              ),
            ),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  Images.profileIcon,
                  color: tabController.index == 2 ? ColorsApp.primaryColor : ColorsApp.black60,
                ),
              ),
              label: "Perfil"),
        ],
      ),
      body: PopScope(
        onPopInvoked: (b) async => false,
        child: SafeArea(
          child: navigatorScreens[tabController.index],
        ),
      ),
    );
  }
}
