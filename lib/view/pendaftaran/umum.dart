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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text(this.title)), body: Container());
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
}
