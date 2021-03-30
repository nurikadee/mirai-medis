import 'package:flutter/material.dart';
import 'package:medis/view/akun/profile.dart';
import 'package:medis/view/home/home.dart';
import 'package:medis/view/jadwalsaya/jadwalsaya.dart';
import 'package:medis/view/pesan/pesan.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> pages = [
    Home(
      key: PageStorageKey('Home'),
    ),
    JadwalSaya(
      key: PageStorageKey('Jadwal Saya'),
    ),
    Pesan(
      key: PageStorageKey('Pesan'),
    ),
    Profile(
      key: PageStorageKey('Profil'),
    ),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy), label: "Jadwal Saya"),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: "Pesan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
