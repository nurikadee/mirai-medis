import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/request/pendaftaran_request.dart';
import 'package:medis/model/request/rujukan_request.dart';
import 'package:medis/model/response/bpjs_rujukan_response.dart';
import 'package:medis/model/response/init_response.dart';
import 'package:medis/model/response/debitur_response.dart';
import 'package:medis/model/response/pendaftaran_response.dart';
import 'package:medis/model/response/poli_response.dart';
import 'package:medis/model/response/polibpjs_to_poli_response.dart';
import 'package:medis/view/pendaftaran/c_poli_bpjs.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_presenter.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_interface.dart';
import 'package:medis/view/pendaftaran/pattern/pendaftaran_view_model.dart';
import 'package:medis/widgets/widget_rounded_input_field.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class BpjsScreen extends StatefulWidget {
  final PendaftaranRequest request;

  BpjsScreen({Key key, this.request}) : super(key: key);

  @override
  _BpjsScreenState createState() => _BpjsScreenState();
}

class _BpjsScreenState extends State<BpjsScreen>
    with PendaftaranViewInterface, LifecycleAware, LifecycleMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PendaftaranRequest request;
  RujukanResponse rujukanResponse;

  List<Rujukan> listRujukan = <Rujukan>[];

  final FocusNode focusNodeNoBpjs = FocusNode();

  TextEditingController noBpjsController = TextEditingController();

  @override
  void initState() {
    this.request = widget.request;

    print(request.toJson().toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MVVMPage<PendaftaranPresenter, PendaftaranViewModel>(
      builder: (context, presenter, model) {
        return Form(
            key: _formKey,
            child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(title: Text("BPJS Kesehatan")),
                body: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(this.context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              Container(
                                child: RoundedInputField(
                                  focusNode: focusNodeNoBpjs,
                                  textEditingController: noBpjsController,
                                  icon: Icons.assignment_ind_outlined,
                                  cursorColor: Colors.black,
                                  editTextBackgroundColor: Colors.grey[200],
                                  iconColor: Colors.grey[500],
                                  textInput: TextInputType.text,
                                  hintText: "Nomor Kartu BPJS",
                                  textStyle: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(this.context).size.width *
                                    0.9,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        RujukanRequest request =
                                            RujukanRequest();
                                        request.nomor = noBpjsController.text;
                                        presenter.getRujukan(request);
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
                                    child: Text("Tampilkan Nomor Rujukan")),
                              ),
                            ],
                          ),
                        ),
                      ),
                      rujukanResponse == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(top: 20, left: 10),
                              child: Text(
                                'Rujukan',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      SizedBox(height: 10),
                      rujukanResponse == null
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: listRujukan.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return InkWell(
                                  onTap: () {
                                    request.noKartuBpjs =
                                        listRujukan[index].peserta.noKartu;
                                    request.noRujukanBpjs =
                                        listRujukan[index].noKunjungan;
                                    Navigator.push(
                                        this.context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PoliBpjsScreen(
                                                    request: request,
                                                    poliBpjs: listRujukan[index]
                                                        .poliRujukan
                                                        .kode)));
                                  },
                                  child: Card(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: ListTile(
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 15),
                                          title: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "${listRujukan[index].peserta.nama}  (${listRujukan[index].noKunjungan})",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  "${listRujukan[index].diagnosa.nama}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  "Poli Rujukan : ${listRujukan[index].poliRujukan.nama}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  "Jenis Pelayanan : ${listRujukan[index].pelayanan.nama}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              })
                    ],
                  ),
                )));
      },
      presenter: PendaftaranPresenter(
          PendaftaranViewModel(), this, PendaftaranPage.BPJS, null),
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
  void showRujukan(RujukanResponse rujukanResponse) {
    setState(() {
      this.rujukanResponse = rujukanResponse;

      if (rujukanResponse.data.rujukan != null) {
        listRujukan.clear();
        Rujukan rujukan = rujukanResponse.data.rujukan;
        listRujukan.add(rujukan);
      }

      if (rujukanResponse.data.listRujukan != null) {
        listRujukan = rujukanResponse.data.listRujukan;
      }
    });
  }

  @override
  void showBpjsToPoli(BpjsToPoliResponse bpjsToPoliResponse) {}

  @override
  void showAfterSubmitPendaftaran(PendaftaranResponse pendaftaranResponse) {}

  @override
  void showPoli(PoliResponse poliResponse) {}
}
