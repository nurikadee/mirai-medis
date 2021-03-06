import 'package:flutter/material.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/utilities/expanded_tile.dart';
import 'package:medis/utilities/expanded_tile_controller.dart';
import 'package:medis/view/pendaftaran/b_bpjs.dart';
import 'package:medis/view/pendaftaran/b_umum.dart';
import 'package:medis/view/pendaftaran/c_poli_umum.dart';

class ItemDebitur extends StatelessWidget {
  final String noRekamMedis;
  final Debitur debitur;
  final String tanggalKunjungan;

  ItemDebitur({this.noRekamMedis, this.debitur, this.tanggalKunjungan});

  @override
  Widget build(BuildContext context) {
    ExpandedTileController _controller = ExpandedTileController();

    PendaftaranRequest request = PendaftaranRequest();
    request.noRekamMedis = noRekamMedis;
    request.tanggalKunjungan = tanggalKunjungan;

    return debitur.kodeDebitur == null
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
                        onTapParent: () {
                          if (debitur.detail.length == 1) {
                            var debiturDetail = debitur.detail[0];

                            request.debiturId = debiturDetail.kodeDebiturDetail;
                            request.debiturName =
                                debiturDetail.namaDebiturDetail;
                            goToDebiturDetail(
                                context,
                                debiturDetail.kodeDebiturDetail,
                                debiturDetail,
                                request);
                          }
                        },
                        controller: _controller,
                        centerHeaderTitle: false,
                        title: Text(
                          debitur.kodeDebitur == null
                              ? ""
                              : debitur.namaDebitur,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        content: debitur.detail.length == 1
                            ? null
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: debitur.detail.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ItemDebiturDetail(
                                      debiturDetail: debitur.detail[index],
                                      request: request);
                                }),
                        contentBackgroundColor: Colors.white,
                      ),
                    ],
                  ),
                )),
          );
  }
}

class ItemDebiturDetail extends StatelessWidget {
  final DebiturDetail debiturDetail;
  final PendaftaranRequest request;

  ItemDebiturDetail({this.debiturDetail, this.request});

  @override
  Widget build(BuildContext context) {
    return debiturDetail.namaDebiturDetail == null
        ? Container()
        : Container(
            padding: EdgeInsets.only(bottom: 3),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: InkWell(
                onTap: () {
                  request.debiturId = debiturDetail.kodeDebiturDetail;
                  request.debiturName = debiturDetail.namaDebiturDetail;

                  goToDebiturDetail(context, debiturDetail.kodeDebiturDetail,
                      debiturDetail, request);
                },
                child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios, size: 10),
                    title: Text(debiturDetail.namaDebiturDetail,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ))),
              ),
            ),
          );
  }
}

void goToDebiturDetail(BuildContext context, String kodeDebitur,
    DebiturDetail debiturDetail, PendaftaranRequest request) {
  StatefulWidget nextScreen;
  print(debiturDetail.toJson().toString());
  switch (kodeDebitur) {
    case "1210":
      nextScreen = BpjsScreen(request: request);
      break;
    case "1012":
      nextScreen =
          UmumScreen(title: debiturDetail.namaDebiturDetail, request: request);
      break;
    default:
      nextScreen = PoliScreen(request: request, isVip: false);
      break;
  }
  if (nextScreen == null) return;
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}
