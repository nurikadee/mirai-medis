import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medis/model/request/batal_daftar_request.dart';
import 'package:medis/model/response/activity_response.dart';
import 'package:medis/utilities/ratting_bar.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/activity/pattern/activity_presenter.dart';

class ItemActivity extends StatefulWidget {
  final Activity activity;
  final ActivityPresenter presenter;

  ItemActivity({this.activity, this.presenter});

  @override
  _ItemActivityState createState() => _ItemActivityState();
}

class _ItemActivityState extends State<ItemActivity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy-MM-dd");

    return Container(
      padding: EdgeInsets.all(3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: widget.activity.statusPembatalan == 1
                          ? Colors.red[300]
                          : Colors.green[100],
                      width: 0.3,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              color: widget.activity.statusPembatalan == 1
                  ? Colors.red[200]
                  : Colors.lightGreen[100],
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      widget.activity.layananWeb
                          ? FontAwesomeIcons.desktop
                          : FontAwesomeIcons.mobileAlt,
                      color: widget.activity.statusPembatalan == 1
                          ? Colors.white
                          : Colors.black,
                      size: 15,
                    ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          widget.activity.poliRsNama,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: widget.activity.statusPembatalan == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        subtitle: Text(
                          Utils.getDateFormat(
                              widget.activity.tanggalPendaftaran),
                          style: TextStyle(
                              color: widget.activity.statusPembatalan == 1
                                  ? Colors.white
                                  : Colors.grey[700]),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    widget.activity.statusPembatalan == 1
                        ? Container()
                        : Container(
                            child: RatingBar(
                              onRatingChanged: (rating) {},
                              //setState(() => _ratingStar = rating),
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              filledColor: Colors.yellow[800],
                              emptyColor: Colors.yellow[800],
                              size: 18,
                            ),
                          ),
                  ],
                ),
              )),
          Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: widget.activity.statusPembatalan == 1
                        ? Colors.red[200]
                        : Colors.green[200],
                    width: 0.3,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              color: widget.activity.statusPembatalan == 1
                  ? Colors.red[100]
                  : Colors.grey[100],
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ListTile(
                        dense: true,
                        title: Text(
                          "Debitur :  ${widget.activity.namaDebitur}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.activity.statusPembatalan == 1
                                  ? "Dibatalkan"
                                  : "Tanggal Kunjungan : ${Utils.getDateFormat(widget.activity.tanggalKunjungan)}",
                              style: TextStyle(
                                  color: widget.activity.statusPembatalan == 1
                                      ? Colors.red
                                      : Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
                            ),
                          ],
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    child: widget.activity.statusPembatalan == 1
                        ? Container()
                        : format
                                .parse(widget.activity.tanggalKunjungan)
                                .isBefore(format.parse(Utils.getCurrentDate()))
                            ? Container()
                            : Container(
                                height: 25,
                                child: FloatingActionButton.extended(
                                    heroTag: widget.activity.pendaftaranId,
                                    elevation: 0,
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 18,
                                    ),
                                    backgroundColor: Colors.red,
                                    onPressed: () {
                                      BatalDaftarRequest request =
                                          BatalDaftarRequest(
                                              pendaftaranId: widget
                                                  .activity.pendaftaranId);
                                      widget.presenter
                                          .cancelPendaftaran(request);
                                    },
                                    label: Text("Batalkan",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10)))),
                  ),
                  SizedBox(width: 10)
                ],
              )),
        ],
      ),
    );
  }
}
