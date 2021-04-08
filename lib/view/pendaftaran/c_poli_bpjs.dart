import 'package:flutter/material.dart';
import 'package:fradio/fradio.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/view/pendaftaran/d_confirm.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class PoliBpjsScreen extends StatefulWidget {
  final PendaftaranRequest request;
  final String poliBpjs;

  PoliBpjsScreen({Key key, this.request, this.poliBpjs}) : super(key: key);

  @override
  _PoliBpjsScreenState createState() => _PoliBpjsScreenState();
}

class _PoliBpjsScreenState extends State<PoliBpjsScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  PendaftaranRequest request;
  String poliBpjs;

  BpjsToPoliResponse bpjsToPoliResponse;

  List<PoliRs> poliRs;
  PoliRs selectedPoliRs;

  @override
  void initState() {
    this.request = widget.request;
    this.poliBpjs = widget.poliBpjs;

    print(request.toJson().toString());

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
                : Container(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Poli yang tersedia berdasarkan nomor Rujukan anda :",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 15),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: poliRs.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              var width =
                                  MediaQuery.of(this.context).size.width;
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: FRadio(
                                    width: width * 0.9,
                                    height: 50,
                                    groupValue: selectedPoliRs,
                                    value: poliRs[index],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPoliRs = value;
                                        print(selectedPoliRs.poliRsNama);
                                      });
                                    },
                                    selectedColor: Colors.grey[350],
                                    corner: FRadioCorner(
                                        leftTopCorner: 6,
                                        leftBottomCorner: 6,
                                        rightBottomCorner: 6,
                                        rightTopCorner: 6),
                                    border: 1,
                                    hasSpace: false,
                                    selectedChild: Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: ListTile(
                                        dense: true,
                                        trailing: Icon(
                                          Icons.check,
                                          color: Colors.lightGreen,
                                        ),
                                        title: Text(
                                            poliRs[index]
                                                .poliRsNama
                                                .toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: ListTile(
                                        dense: true,
                                        title: Text(
                                            poliRs[index]
                                                .poliRsNama
                                                .toUpperCase(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    )),
                              );
                            }),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(this.context).size.width * 0.8,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                if (selectedPoliRs == null) {
                                  showMessage(
                                      "Pilih poli terlebih dahulu", true);
                                } else {
                                  request.poliRsId = selectedPoliRs.poliRsId;
                                  request.poliRsName =
                                      selectedPoliRs.poliRsNama;

                                  Navigator.push(
                                      this.context,
                                      MaterialPageRoute(
                                          builder: (context) => ConfirmScreen(
                                                request: request,
                                              )));
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.green)))),
                              child: Text("Lanjut mendaftar ke Poli ini")),
                        ),
                      ],
                    )));
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
      gravity: Toast.CENTER,
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
      this.selectedPoliRs = poliRs[0];
    });
  }

  @override
  void showAfterSubmitPendaftaran(PendaftaranResponse pendaftaranResponse) {}

  @override
  void showPoli(PoliResponse poliResponse) {}
}
