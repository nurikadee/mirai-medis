import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class DaftarPoliScreen extends StatefulWidget {
  final PendaftaranRequest request;
  final String poliBpjs;

  DaftarPoliScreen({Key key, this.request, this.poliBpjs}) : super(key: key);

  @override
  _DaftarPoliScreenState createState() => _DaftarPoliScreenState();
}

class _DaftarPoliScreenState extends State<DaftarPoliScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  PendaftaranRequest request;
  String poliBpjs;

  BpjsToPoliResponse bpjsToPoliResponse;

  List<PoliRs> poliRs;

  @override
  void initState() {
    this.request = widget.request;
    this.poliBpjs = widget.poliBpjs;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Pilih Poli")),
            body: bpjsToPoliResponse == null
                ? Container()
                : ListView.builder(
                    itemCount: poliRs.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          child: ListTile(
                              trailing: Icon(Icons.arrow_forward_ios_outlined,
                                  size: 15),
                              title: Text(
                                poliRs[index].poliRsNama,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              )),
                        ),
                      );
                    }));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.POLI, poliBpjs),
    );
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
  void showDays(InitResponse daysResponse) {}

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
  void showDebitur(DebiturResponse debiturResponse) {}

  @override
  void showRujukan(RujukanResponse rujukanResponse) {}

  @override
  void showBpjsToPoli(BpjsToPoliResponse bpjsToPoliResponse) {
    setState(() {
      this.bpjsToPoliResponse = bpjsToPoliResponse;
      this.poliRs = bpjsToPoliResponse.data.poliRs;
    });
  }
}
