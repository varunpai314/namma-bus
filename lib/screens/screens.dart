import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namma_bus/screens/map_screen.dart';
import 'package:namma_bus/screens/ticket_screen.dart';
import 'package:namma_bus/screens/timings_screen.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  var selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    Widget screen;
    switch (selectedIndex) {
      case 0:
        screen = const TimingsScreen();
      case 1:
        screen = const MapScreen();
      case 2:
        screen = const TicketScreen();
      default:
        screen = const MapScreen();
    }
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: const [
              ListTile(
                title: Text('Home'),
              ),
              ListTile(
                title: Text('Profile'),
              ),
              ListTile(
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            screen,
            Positioned(
              top: 2.0,
              right: 2.0,
              child: Builder(builder: (context) {
                return IconButton(
                  icon: SvgPicture.asset(
                    'assets/profile.svg',
                    height: 50.0,
                    width: 50.0,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              }),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
                icon: Image.asset('assets/timings.png'), label: 'Timings'),
            NavigationDestination(
                icon: Image.asset('assets/map.png'), label: 'Map'),
            NavigationDestination(
                icon: Image.asset('assets/ticket.png'), label: 'Ticket'),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
