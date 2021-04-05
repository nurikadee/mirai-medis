import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/dokter_by_poli_response.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/model/response/jadwal_dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_presenter.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:medis/view/dokter/search_page.dart';
import 'package:medis/widgets/item_dokter.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class DokterScreen extends StatefulWidget {
  @override
  _DokterState createState() => _DokterState();
}

class _DokterState extends State<DokterScreen>
    with DokterViewInterface, LifecycleAware, LifecycleMixin {
  var listData = ListView();

  DokterResponse dokterResponse;
  List<Dokter> listDokter;

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
    if (dokterResponse != null) {
      listData = ListView.builder(
          itemCount: listDokter.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ItemDokter(dokter: listDokter[index]);
          });
    }

    return MVVMPage<DokterPresenter, DokterViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
          appBar: AppBar(title: Text("Dokter")),
          body: listData,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            heroTag: "Cari",
            label: Text('Cari Dokter',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[700])),
            icon: Icon(Icons.search, color: Colors.grey[700]),
            backgroundColor: Colors.white,
            tooltip: 'Cari dokter',
            onPressed: () => showSearch(
              context: this.context,
              delegate: SearchPage<Dokter>(
                items: dokterResponse.data,
                searchLabel: 'Cari dokter',
                suggestion: Center(
                  child: Text('Cari dokter berdasarkan nama'),
                ),
                failure: Center(
                  child: Text('Data dokter tidak ditemukan'),
                ),
                filter: (dokter) => [dokter.namaLengkap],
                builder: (dokter) => ItemDokter(dokter: dokter),
              ),
            ),
          ),
        );
      },
      presenter:
          DokterPresenter(DokterViewModel(), this, DokterPage.DOKTER, null),
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
  void showListDokter(DokterResponse dokterResponse) {
    setState(() {
      this.dokterResponse = dokterResponse;
      this.listDokter = dokterResponse.data;
    });
  }

  @override
  void showListDokterByPoli(DokterByPoliResponse dokterByPoliResponse) {}

  @override
  void showListJadwalDokter(JadwalDokterResponse jadwalDokterResponse) {}
}
