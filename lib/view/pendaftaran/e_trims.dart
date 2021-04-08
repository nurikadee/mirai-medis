import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/login_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/utilities/utils.dart';
import 'package:medis/view/home/bottombar.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class TrimsScreen extends StatefulWidget {
  final PendaftaranResponse response;

  TrimsScreen({Key key, this.response}) : super(key: key);

  @override
  _TrimsScreenState createState() => _TrimsScreenState();
}

class _TrimsScreenState extends State<TrimsScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  DataUser dataUser;
  PendaftaranResponse response;

  @override
  void initState() {
    this.response = widget.response;
    print(response.toJson().toString());

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
            appBar: AppBar(title: Text("Terima Kasih")),
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
                    color: Colors.green[50],
                    child: Container(
                      width: MediaQuery.of(this.context).size.width,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'No Antrian Anda :',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: Text(
                              response.data.nomorAntrian,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Text(
                              response.data.poliRsNama,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                              Utils.getDateFormat(
                                  response.data.tanggalKunjungan),
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
                              response.data.namaDebitur,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.green[500],
                      child: InkWell(
                        onTap: () {
                          Navigator.of(this.context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()),
                              (Route<dynamic> route) => false);
                        },
                        child: ListTile(
                            trailing: Icon(Icons.home, color: Colors.white),
                            dense: true,
                            title: Text(
                              "Kembali ke Menu Utama",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )),
                  SizedBox(height: 10),
                ],
              ),
            ));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.CONFIRM, null),
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
