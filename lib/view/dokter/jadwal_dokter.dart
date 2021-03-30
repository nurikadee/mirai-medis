import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_presenter.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:medis/widgets/item_jadwal_dokter.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class JadwalDokterScreen extends StatefulWidget {
  final Dokter dokter;

  const JadwalDokterScreen({Key key, this.dokter}) : super(key: key);

  @override
  _JadwalDokterState createState() => _JadwalDokterState();
}

class _JadwalDokterState extends State<JadwalDokterScreen>
    with DokterViewInterface, LifecycleAware, LifecycleMixin {
  var listData = Container();

  String namaDokter;
  Dokter dokter;
  JadwalDokterResponse jadwalDokterResponse;

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    this.dokter = widget.dokter;

    var gelarDepan =
        dokter.gelarSarjanaDepan == null ? "" : dokter.gelarSarjanaDepan;
    var gelarBelakang =
        dokter.gelarSarjanaBelakang == null ? "" : dokter.gelarSarjanaBelakang;
    namaDokter = dokter.nama == null
        ? ""
        : "$gelarDepan ${dokter.namaLengkap} $gelarBelakang";
  }

  @override
  Widget build(BuildContext context) {
    if (jadwalDokterResponse != null) {
      listData = Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            Expanded(
                child: ItemJadwalDokterList(response: jadwalDokterResponse))
          ]));
    }

    return MVVMPage<DokterPresenter, DokterViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text(namaDokter)), body: listData);
      },
      presenter: DokterPresenter(DokterViewModel(), this,
          DokterPage.JADWAL_DOKTER, dokter.pegawaiId.toString()),
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
  void showListDokterByPoli(DokterByPoliResponse dokterByPoliResponse) {}

  @override
  void showListJadwalDokter(JadwalDokterResponse jadwalDokterResponse) {
    setState(() {
      this.jadwalDokterResponse = jadwalDokterResponse;
    });
  }
}
