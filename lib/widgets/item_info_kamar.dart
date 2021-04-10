import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medis/model/response/info_kamar_rawat_response.dart';
import 'package:medis/utilities/expanded_tile.dart';
import 'package:medis/utilities/expanded_tile_controller.dart';

class ItemInfoKamarList extends StatelessWidget {
  final InfoKamarRawatResponse response;

  ItemInfoKamarList({this.response});

  @override
  Widget build(BuildContext context) {
    List<Kelas> listKelas = this.response.data;
    if (listKelas.isNotEmpty) {
      return ListView.builder(
          itemCount: listKelas.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ItemInfoKelas(kelas: listKelas[index]);
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
                Text("Info kamar tidak tersedia", textAlign: TextAlign.center)
              ]));
    }
  }
}

class ItemInfoKelas extends StatelessWidget {
  final Kelas kelas;

  ItemInfoKelas({this.kelas});

  @override
  Widget build(BuildContext context) {
    ExpandedTileController _controller = ExpandedTileController();

    return kelas.namaKelas == null
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
                          kelas.namaKelas == null ? "" : kelas.namaKelas,
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
                            itemCount: kelas.ruangan.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return ItemRuangan(ruangan: kelas.ruangan[index]);
                            }),
                        contentBackgroundColor: Colors.white,
                      ),
                    ],
                  ),
                )),
          );
  }
}

class ItemRuangan extends StatelessWidget {
  final Ruangan ruangan;

  ItemRuangan({this.ruangan});

  @override
  Widget build(BuildContext context) {
    var available = 0;
    var notAvailable = 0;

    for (Kamar kamar in ruangan.kamar) {
      if (kamar.available) {
        available++;
      }
      if (!kamar.available) {
        notAvailable++;
      }
    }
    return ruangan.namaRuang == null
        ? Container()
        : Container(
            margin: EdgeInsets.all(3),
            color: Colors.grey[100],
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.doorOpen,
                    size: 20,
                  ),
                  title: Transform(
                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                      child: Text(ruangan.namaRuang,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ))),
                  subtitle: Transform(
                      transform: Matrix4.translationValues(-20, 0.0, 0.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0,
                                color: Colors.yellow[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("Total : ${ruangan.kamar.length}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 0,
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("Tersedia : $available",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                elevation: 0,
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("Terisi : $notAvailable",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
            ),
          );
  }
}
