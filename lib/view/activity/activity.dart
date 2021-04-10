import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/activity_response.dart';
import 'package:medis/utilities/ratting_bar.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/activity/pattern/activity_presenter.dart';
import 'package:medis/view/activity/pattern/activity_view_interface.dart';
import 'package:medis/view/activity/pattern/activity_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with ActivityViewInterface, LifecycleAware, LifecycleMixin {
  var listData = Container();

  ActivityResponse activityResponse;
  int get count => list.length;
  List<Activity> list;
  bool isFinish = false;

  DateFormat format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    if (activityResponse != null) {
      listData = Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return itemActivity(list[index]);
              }));
    }

    return MVVMPage<ActivityPresenter, ActivityViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Riwayat Aktifitas Pasien")),
            body: RefreshIndicator(
                onRefresh: () {
                  return _refresh(presenter);
                },
                child: listData));
      },
      presenter:
          ActivityPresenter(ActivityViewModel(), this, ActivityPage.ACTIVITY),
    );
  }

  Widget itemActivity(Activity activity) {
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
                      color: activity.statusPembatalan == 1
                          ? Colors.red[300]
                          : Colors.green[100],
                      width: 0.3,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              color: activity.statusPembatalan == 1
                  ? Colors.red[200]
                  : Colors.lightGreen[100],
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      activity.layananWeb
                          ? FontAwesomeIcons.desktop
                          : FontAwesomeIcons.mobileAlt,
                      color: activity.statusPembatalan == 1
                          ? Colors.white
                          : Colors.black,
                      size: 15,
                    ),
                    Expanded(
                      child: ListTile(
                        dense: true,
                        title: Text(
                          activity.poliRsNama,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: activity.statusPembatalan == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        subtitle: Text(
                          Utils.getDateFormat(activity.tanggalPendaftaran),
                          style: TextStyle(
                              color: activity.statusPembatalan == 1
                                  ? Colors.white
                                  : Colors.grey[700]),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    activity.statusPembatalan == 1
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
                    color: activity.statusPembatalan == 1
                        ? Colors.red[200]
                        : Colors.green[200],
                    width: 0.3,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              color: activity.statusPembatalan == 1
                  ? Colors.red[100]
                  : Colors.grey[100],
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ListTile(
                        dense: true,
                        title: Text(
                          "Debitur :  ${activity.namaDebitur}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.statusPembatalan == 1
                                  ? "Dibatalkan"
                                  : "Tanggal Kunjungan : ${Utils.getDateFormat(activity.tanggalKunjungan)}",
                              style: TextStyle(
                                  color: activity.statusPembatalan == 1
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
                    child: activity.statusPembatalan == 1
                        ? Container()
                        : format
                                .parse(activity.tanggalKunjungan)
                                .isBefore(format.parse(Utils.getCurrentDate()))
                            ? Container()
                            : Container(
                                height: 25,
                                child: FloatingActionButton.extended(
                                    elevation: 0,
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 18,
                                    ),
                                    backgroundColor: Colors.red,
                                    onPressed: () {},
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

  Future<void> _refresh(ActivityPresenter presenter) async {
    presenter.getActivity();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {}

  @override
  void showMessage(String message, bool error) {
    Toast.show(
      message,
      context,
      backgroundColor: error ? Colors.red : Colors.green[400],
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }

  @override
  void showActivity(ActivityResponse activityResponse) {
    setState(() {
      this.activityResponse = activityResponse;
      this.list = activityResponse.data;

      list.sort((a, b) => format
          .parse(b.tanggalPendaftaran)
          .compareTo(format.parse(a.tanggalPendaftaran)));
    });
  }
}
