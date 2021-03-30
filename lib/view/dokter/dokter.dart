import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/dokter_response.dart';
import 'package:medis/view/dokter/pattern/dokter_presenter.dart';
import 'package:medis/view/dokter/pattern/dokter_view_interface.dart';
import 'package:medis/view/dokter/pattern/dokter_view_model.dart';
import 'package:medis/widgets/item_dokter.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class DokterScreen extends StatefulWidget {
  @override
  _DokterState createState() => _DokterState();
}

class _DokterState extends State<DokterScreen>
    with DokterViewInterface, LifecycleAware, LifecycleMixin {
  var listData = Container();

  DokterResponse dokterResponse;

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
      listData = Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            Expanded(child: ItemDokterList(response: dokterResponse))
          ]));
    }

    return MVVMPage<DokterPresenter, DokterViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(appBar: AppBar(title: Text("Dokter")), body: listData);
      },
      presenter: DokterPresenter(DokterViewModel(), this),
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
    });
  }
}
