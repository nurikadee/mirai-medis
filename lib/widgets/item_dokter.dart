import 'package:flutter/material.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/view/dokter/jadwal_dokter.dart';

class ItemDokter extends StatelessWidget {
  final Dokter dokter;

  ItemDokter({this.dokter});

  @override
  Widget build(BuildContext context) {
    var gelarDepan =
        dokter.gelarSarjanaDepan == null ? "" : dokter.gelarSarjanaDepan;
    var gelarBelakang =
        dokter.gelarSarjanaBelakang == null ? "" : dokter.gelarSarjanaBelakang;
    var namaDokter = dokter.nama == null
        ? ""
        : "$gelarDepan ${dokter.namaLengkap} $gelarBelakang";

    return dokter.nama == null
        ? Container()
        : InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          JadwalDokterScreen(dokter: dokter)));
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                    dense: true,
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                    leading:
                        Image.asset("assets/images/ic_doctor.png", width: 25),
                    title: Transform(
                        transform: Matrix4.translationValues(-16, 0.0, 0.0),
                        child: Text(namaDokter,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)))),
              ),
            ),
          );
  }
}
