import 'package:flutter/material.dart';
import 'package:medis/view/dokter/dokter.dart';
import 'package:medis/view/dokter/jadwal_praktik.dart';
import 'package:medis/view/infokamar/info_kamar.dart';
import 'package:medis/view/pendaftaran/pendaftaran.dart';

class DashboardMenu {
  StatefulWidget directTo;
  String title;
  String icon;

  DashboardMenu({this.directTo, this.title, this.icon});
}

var pendaftaran = DashboardMenu(
  directTo: Pendaftaran(),
  title: "Pendaftaran",
  icon: "assets/images/ic_registration.png",
);

var dokter = DashboardMenu(
  directTo: DokterScreen(),
  title: "Dokter",
  icon: "assets/images/ic_doctor.png",
);

var infokamar = DashboardMenu(
  directTo: InfoKamar(),
  title: "Info Kamar",
  icon: "assets/images/ic_bed.png",
);

var jadwalPraktik = DashboardMenu(
  directTo: JadwalPraktikScreen(),
  title: "Jadwal Praktik",
  icon: "assets/images/ic_rs.png",
);

final menu = [pendaftaran, dokter, infokamar, jadwalPraktik];

final List<String> imgList = [
  "assets/images/1.png",
  "assets/images/2.png",
  "assets/images/3.png",
  "assets/images/4.png",
  "assets/images/5.png",
  "assets/images/6.png",
  "assets/images/7.png",
  "assets/images/8.png",
  "assets/images/9.png",
  "assets/images/10.png",
];

List<Widget> imageSliders(BuildContext context) {
  return imgList
      .map(
        (item) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 5,
          margin: EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.asset(item, fit: BoxFit.cover),
          ),
        ),
      )
      .toList();
}
