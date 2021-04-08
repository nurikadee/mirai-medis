import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/login_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/pendaftaran/e_trims.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class ConfirmScreen extends StatefulWidget {
  final PendaftaranRequest request;

  ConfirmScreen({Key key, this.request}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  DataUser dataUser;
  PendaftaranRequest request;

  @override
  void initState() {
    this.request = widget.request;

    print(request.toJson().toString());

    getUserLogin();

    super.initState();
  }

  void getUserLogin() {
    Pref.getUserLogin().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Scaffold(
            appBar: AppBar(title: Text("Konfirmasi")),
            body: Container(
              width: MediaQuery.of(this.context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.grey[200],
                    child: Container(
                      width: MediaQuery.of(this.context).size.width,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Pendaftaran ke :',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: Text(
                              request.poliRsName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'Nama Pasien / No. Rekam Medis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(height: 3),
                          dataUser == null
                              ? Container()
                              : Container(
                                  child: Text(
                                    "${dataUser.pasien.nama} / ${dataUser.pasien.kode}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(height: 10),
                          Container(
                            child: Text(
                              'Hari, Tanggal Kunjungan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            child: Text(
                              Utils.getDateFormat(request.tanggalKunjungan),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Text(
                              request.debiturName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          request.debiturId == "1210"
                              ? Container(
                                  child: Text(
                                    request.noRujukanBpjs,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.red[400],
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(this.context);
                              },
                              child: ListTile(
                                  leading:
                                      Icon(Icons.close, color: Colors.white),
                                  dense: true,
                                  title: Text(
                                    "Batal",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.green[500],
                            child: InkWell(
                              onTap: () {
                                showAlertDialog(this.context, presenter);
                              },
                              child: ListTile(
                                  trailing:
                                      Icon(Icons.send, color: Colors.white),
                                  dense: true,
                                  title: Text(
                                    "Kirim",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Text(
                      '* Periksa kembali nomor rujukan dan poli tujuan anda, ' +
                          'dan pastikan anda melakukan konfirmasi pendaftaran ' +
                          'di mesin APM RSUD Arifin Achmad pada hari / tanggal ' +
                          'pasien melakukan kunjungan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.CONFIRM, null),
    );
  }

  showAlertDialog(BuildContext context, PendaftaranPresenter presenter) {
    Widget cancelButton = Card(
        color: Colors.red,
        child: TextButton(
          child: Text("Batal", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pop(this.context);
          },
        ));
    Widget continueButton = Card(
        color: Colors.green,
        child: TextButton(
          child: Text("Ya", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pop(context);
            presenter.sendToDaftarPoli(request);
          },
        ));
    AlertDialog alert = AlertDialog(
      title: Text(
        "PENTING",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red, fontSize: 16, fontWeight: FontWeight.normal),
      ),
      content: Text(
          "Apakan anda sudah yakin untuk mendaftar pada ${request.poliRsName}, " +
              "hari ${Utils.getDateFormat(request.tanggalKunjungan)} ?",
          style: TextStyle(
              color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)),
      actionsPadding: EdgeInsets.all(10),
      actionsOverflowButtonSpacing: 10,
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
  void showAfterSubmitPendaftaran(PendaftaranResponse pendaftaranResponse) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrimsScreen(response: pendaftaranResponse)));
  }

  @override
  void showPoli(PoliResponse poliResponse) {}
}
