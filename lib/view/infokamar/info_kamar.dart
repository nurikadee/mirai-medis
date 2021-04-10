import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/info_kamar_rawat_response.dart';
import 'package:medis/view/infokamar/pattern/rawatinap_presenter.dart';
import 'package:medis/view/infokamar/pattern/rawatinap_view_interface.dart';
import 'package:medis/view/infokamar/pattern/rawatinap_view_model.dart';
import 'package:medis/widgets/item_info_kamar.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class InfoKamar extends StatefulWidget {
  InfoKamar({Key key}) : super(key: key);

  @override
  _InfoKamarState createState() => _InfoKamarState();
}

class _InfoKamarState extends State<InfoKamar>
    with RawatInapViewInterface, LifecycleAware, LifecycleMixin {
  var listData = Container();

  InfoKamarRawatResponse infoKamarRawatResponse;

  @override
  Widget build(BuildContext context) {
    if (infoKamarRawatResponse != null) {
      listData = Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            Expanded(child: ItemInfoKamarList(response: infoKamarRawatResponse))
          ]));
    }

    return MVVMPage<RawatInapPresenter, RawatInapViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Info Kamar Rawat")), body: listData);
      },
      presenter: RawatInapPresenter(
          RawatInapViewModel(), this, RawatInapPage.INFO_KAMAR),
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
  void showListKamar(InfoKamarRawatResponse infoKamarRawatResponse) {
    setState(() {
      this.infoKamarRawatResponse = infoKamarRawatResponse;
    });
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
}
