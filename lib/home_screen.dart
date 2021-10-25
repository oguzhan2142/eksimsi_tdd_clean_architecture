import 'package:eksimsi_tdd_clean_architecture/core/constants/colors.dart';
import 'package:eksimsi_tdd_clean_architecture/core/pages/channels_tab.dart';
import 'package:eksimsi_tdd_clean_architecture/core/pages/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'core/pages/archive_tab.dart';
import 'core/pages/agenda_tab.dart';
import 'core/pages/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  PageController controller = PageController();

  List<Widget> pages = [
    AgendaTab(),
    ChannelsTab(),
    SearchTab(),
    ArchiveTab(),
    ProfileTab(),
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
        title: Row(
          children: [
            FlutterLogo(),
            SizedBox(width: 10),
            Text(
              'Ekşimsi',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          selectedIndex == pages.length - 1
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.settings_solid),
                )
              : SizedBox(),
        ],
      ),
      body: PageView.builder(
        controller: controller,
        itemBuilder: (context, position) => pages[position],
        itemCount: pages.length,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 18),
        decoration: BoxDecoration(
          color: MAIN_COLOR,
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
            gap: 2,
            tabBorderRadius: 30,
            color: Colors.grey[300],
            activeColor: SECONDARY_COLOR,
            iconSize: 16,
            textStyle: TextStyle(fontSize: 12, color: SECONDARY_COLOR),
            tabBackgroundColor: Colors.grey[800]!,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16.5),
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
