import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:medis/widgets/item_debitur.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class Pendaftaran extends StatefulWidget {
  Pendaftaran({Key key}) : super(key: key);

  @override
  _PendaftaranState createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pendaftaran>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  InitResponse initResponses;
  List<String> twoDaysFromNow;
  List<Debitur> debiturs;

  String selectedDate = '';

  @override
  Widget build(BuildContext context) {
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Pendaftaran")),
            body: initResponses == null
                ? Container()
                : Container(
                    padding: EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "Pilih Tanggal Kunjungan : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownButton<String>(
                                        value: selectedDate,
                                        icon: Icon(Icons.arrow_drop_down),
                                        isExpanded: true,
                                        iconSize: 20,
                                        underline: SizedBox(),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            selectedDate = newValue;
                                          });
                                        },
                                        items: twoDaysFromNow
                                            .sublist(0, 2)
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                                child: Text(
                                              Utils.getDateFormat(value),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )),
                                          );
                                        }).toList()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "Tanggal pendaftaran tersedia pada H-1 dan H-2 dari tanggal hari ini.",
                            style: TextStyle(
                                fontSize: 12, color: Colors.green[700]),
                          ),
                        ),
                        SizedBox(height: 15),
                        initResponses == null
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: debiturs.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ItemDebitur(
                                      debitur: debiturs[index],
                                      tanggalKunjungan: selectedDate);
                                })
                      ],
                    ),
                  ));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.PENDAFTARAN, null),
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
  void showDays(InitResponse initResponses) {
    setState(() {
      this.initResponses = initResponses;
      var today = Utils.getCurrentDate();

      if (today == this.initResponses.data.weekdays[0]) {
        this.twoDaysFromNow = this
            .initResponses
            .data
            .weekdays
            .sublist(1, this.initResponses.data.weekdays.length - 1);
      } else {
        this.twoDaysFromNow = this.initResponses.data.weekdays;
      }

      selectedDate = twoDaysFromNow[0];

      this.debiturs = initResponses.data.debitur;
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

  @override
  void showDebitur(DebiturResponse debiturResponse) {}

  @override
  void showRujukan(RujukanResponse rujukanResponse) {}

  @override
  void showBpjsToPoli(BpjsToPoliResponse bpjsToPoliResponse) {}
}
