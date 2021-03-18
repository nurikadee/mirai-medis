import 'package:flutter/material.dart';

class SettingsMenu {
  Icon icon;
  String title;
  String subtitle;

  SettingsMenu({this.icon, this.title, this.subtitle});
}

final settingsMenu = [
  SettingsMenu(
    icon: Icon(Icons.account_circle, size: 40.0),
    title: 'Identitas / Data Pegawai',
    subtitle: 'Biodata diri, penempatan, jabatan dll',
  ),
  SettingsMenu(
    icon: Icon(Icons.keyboard, size: 40.0),
    title: 'Ubah Password',
    subtitle: 'Ubah password anda jika akun dibuka diperangkat lain',
  ),
  SettingsMenu(
    icon: Icon(Icons.circle_notifications, size: 40.0),
    title: 'Notifikasi',
    subtitle: 'Notifkasi dari pihak Management, System',
  ),
  SettingsMenu(
    icon: Icon(Icons.logout, size: 40.0),
    title: 'Logout',
    subtitle: 'Untuk keluar dari aplikasi',
  ),
];
