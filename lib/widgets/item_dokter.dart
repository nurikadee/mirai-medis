import 'package:flutter/material.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/utilities/expanded_tile.dart';
import 'package:medis/utilities/expanded_tile_controller.dart';

class ItemDokterList extends StatelessWidget {
  final DokterResponse response;

  ItemDokterList({this.response});

  @override
  Widget build(BuildContext context) {
    List<PenempatanDokter> listPoli = this.response.data;
    if (listPoli.isNotEmpty) {
      return ListView.builder(
          itemCount: listPoli.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ItemPoli(poli: listPoli[index]);
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
                Text("Data Poli tidak ditemukan", textAlign: TextAlign.center)
              ]));
    }
  }
}

class ItemPoli extends StatelessWidget {
  final PenempatanDokter poli;

  ItemPoli({this.poli});

  @override
  Widget build(BuildContext context) {
    ExpandedTileController _controller = ExpandedTileController();
    return poli.nama == null
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
                          poli.nama == null ? "" : poli.nama,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        content: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: poli.dokter.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return ItemDokter(dokter: poli.dokter[index]);
                            }),
                        contentBackgroundColor: Colors.white,
                      ),
                    ],
                  ),
                )),
          );
  }
}

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
        : Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(namaDokter,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
            ),
          );
  }
}
