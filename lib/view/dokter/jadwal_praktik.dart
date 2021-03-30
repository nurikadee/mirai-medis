import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_presenter.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:medis/widgets/item_dokter_by_poli.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class JadwalPraktikScreen extends StatefulWidget {
  @override
  _JadwalPraktikState createState() => _JadwalPraktikState();
}

class _JadwalPraktikState extends State<JadwalPraktikScreen>
    with DokterViewInterface, LifecycleAware, LifecycleMixin {
  var listData = Container();

  DokterByPoliResponse dokterByPoliResponse;

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dokterByPoliResponse != null) {
      listData = Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            Expanded(
                child: ItemDokterByPoliList(response: dokterByPoliResponse))
          ]));
    }

    return MVVMPage<DokterPresenter, DokterViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Jadwal Praktik Dokter")),
            body: listData);
      },
      presenter: DokterPresenter(
          DokterViewModel(), this, DokterPage.JADWAL_PRAKTIK, null),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
  void showListDokter(DokterResponse dokterResponse) {}

  @override
  void showListDokterByPoli(DokterByPoliResponse dokterByPoliResponse) {
    setState(() {
      this.dokterByPoliResponse = dokterByPoliResponse;
    });
  }

  @override
  void showListJadwalDokter(JadwalDokterResponse jadwalDokterResponse) {}
}
