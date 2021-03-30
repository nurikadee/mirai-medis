import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:medis/utilities/expanded_tile.dart';
import 'package:medis/utilities/expanded_tile_controller.dart';
import 'package:medis/utilities/utils.dart';

class ItemJadwalDokterList extends StatelessWidget {
  final JadwalDokterResponse response;

  ItemJadwalDokterList({this.response});

  @override
  Widget build(BuildContext context) {
    List<JadwalDokter> listJadwalDokter = this.response.data;
    if (listJadwalDokter.isNotEmpty) {
      return ListView.builder(
          itemCount: listJadwalDokter.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ItemJadwalDokter(jadwalDokter: listJadwalDokter[index]);
          });
    } else {
      return Container(
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/empty_state_2.png",
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 20),
                Text("Jadwal Dokter tidak ditemukan",
                    textAlign: TextAlign.center)
              ]));
    }
  }
}

class ItemJadwalDokter extends StatelessWidget {
  final JadwalDokter jadwalDokter;

  ItemJadwalDokter({this.jadwalDokter});

  @override
  Widget build(BuildContext context) {
    ExpandedTileController _controller = ExpandedTileController();

    return jadwalDokter.pegawaiId == null
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandedTile(
                        controller: _controller,
                        centerHeaderTitle: false,
                        title: Text(
                          jadwalDokter.tanggal == null
                              ? ""
                              : Utils.getDateFormat(jadwalDokter.tanggal),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        content: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: jadwalDokter.jadwalPraktik.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return ItemJadwalPraktik(
                                  jadwalPraktik:
                                      jadwalDokter.jadwalPraktik[index]);
                            }),
                        contentBackgroundColor: Colors.white,
                      ),
                    ],
                  ),
                )),
          );
  }
}

class ItemJadwalPraktik extends StatelessWidget {
  final JadwalPraktik jadwalPraktik;

  ItemJadwalPraktik({this.jadwalPraktik});

  @override
  Widget build(BuildContext context) {
    return jadwalPraktik.jam == null
        ? Container()
        : Container(
            padding: EdgeInsets.only(bottom: 3),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: ListTile(
                  dense: true,
                  leading: Icon(
                    FontAwesomeIcons.clock,
                    size: 20,
                  ),
                  title: Transform(
                      transform: Matrix4.translationValues(-25, 0.0, 0.0),
                      child: Text(jadwalPraktik.jam,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          )))),
            ),
          );
  }
}
