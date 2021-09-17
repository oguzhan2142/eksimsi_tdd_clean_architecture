import 'package:eksimsi_tdd_clean_architecture/core/pages/channels_page.dart';
import 'package:eksimsi_tdd_clean_architecture/core/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'core/pages/archive_page.dart';
import 'core/pages/agenda_page.dart';
import 'core/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  PageController controller = PageController();

  List<Widget> pages = [
    AgendaPage(),
    ChannelsPage(),
    SearchPage(),
    ArchivePage(),
    ProfilePage(),
  ];

  void _tabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });

    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Ekşimsi'),
      ),
      body: PageView.builder(
        controller: controller,
        itemBuilder: (context, position) => pages[position],
        itemCount: pages.length,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 60,
              color: Colors.black.withOpacity(.4),
              offset: Offset(0, 25),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
          child: GNav(
            tabBackgroundGradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.teal.shade100, Colors.teal.shade500],
            ),
            gap: 10,
            tabBorderRadius: 30,
            color: Colors.grey[600],
            activeColor: Colors.white,
            iconSize: 16,
            textStyle: TextStyle(fontSize: 12, color: Colors.white),
            tabBackgroundColor: Colors.grey[800]!,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
            duration: Duration(milliseconds: 800),
            tabs: [
              GButton(
                icon: LineIcons.newspaper,
                text: 'Gündem',
              ),
              GButton(
                icon: LineIcons.connectDevelop,
                text: 'Kanallar',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Arama',
              ),
              GButton(
                icon: LineIcons.archive,
                text: 'Arşiv',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: _tabChanged,
          ),
        ),
      ),
    );
  }
}
