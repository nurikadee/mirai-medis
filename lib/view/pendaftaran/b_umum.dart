import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/view/pendaftaran/c_poli_umum.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class UmumScreen extends StatefulWidget {
  final String title;
  final PendaftaranRequest request;

  UmumScreen({Key key, this.request, this.title}) : super(key: key);

  @override
  _UmumScreenState createState() => _UmumScreenState();
}

class _UmumScreenState extends State<UmumScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  String title;
  PendaftaranRequest request;

  @override
  void initState() {
    this.title = widget.title;
    this.request = widget.request;

    print(request.toJson().toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text(this.title)),
            body: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: (context) => PoliScreen(
                                    request: request, isVip: false)));
                      },
                      child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios, size: 10),
                          title: Text("Non VIP",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PoliScreen(request: request, isVip: true)));
                      },
                      child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios, size: 10),
                          title: Text("VIP",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                ],
              ),
            ));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.UMUM, null),
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
  void showBpjsToPoli(BpjsToPoliResponse bpjsToPoliResponse) {}

  @override
  void showAfterSubmitPendaftaran(PendaftaranResponse pendaftaranResponse) {}

  @override
  void showPoli(PoliResponse poliResponse) {}
}
