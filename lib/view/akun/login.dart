import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/request/login_request.dart';
import 'package:medis/model/response/login_response.dart';
import 'package:medis/view/akun/pattern/auth_presenter.dart';
import 'package:medis/view/akun/pattern/auth_view_interface.dart';
import 'package:medis/view/akun/pattern/auth_view_model.dart';
import 'package:medis/widgets/widget_rounded_input_field.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with AuthViewInterface, LifecycleAware, LifecycleMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode focusNodeUserNameLogin = FocusNode();
  final FocusNode focusNodeTanggalLogin = FocusNode();

  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginTanggalController = TextEditingController();

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    debugPrint(event.toString());
    if (event == LifecycleEvent.active) {
      Pref.checkIsLoggedIn().then((value) {
        if (value) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MVVMPage<AuthPresenter, AuthViewModel>(
      builder: (context, presenter, model) {
        return Form(
            key: _formKey,
            child: Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Masuk sebagai Pasien",
                    style: TextStyle(color: Colors.grey[700])),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.grey),
              ),
              body: Container(
                margin: EdgeInsets.all(30),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Hero(
                        tag: 'Logo',
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 60.0,
                          child: Image.asset('assets/images/rsudaa.png'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: RoundedInputField(
                          focusNode: focusNodeUserNameLogin,
                          textEditingController: loginUserNameController,
                          icon: Icons.person,
                          cursorColor: Colors.black,
                          editTextBackgroundColor: Colors.grey[200],
                          iconColor: Colors.grey[500],
                          textInput: TextInputType.text,
                          hintText: "Nomor Rekam Medis / Nomor Identitas",
                          textStyle:
                              TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                      Container(
                        child: RoundedInputField(
                          focusNode: focusNodeTanggalLogin,
                          textEditingController: loginTanggalController,
                          icon: Icons.date_range,
                          cursorColor: Colors.black,
                          editTextBackgroundColor: Colors.grey[200],
                          iconColor: Colors.grey[500],
                          textInput: TextInputType.text,
                          hintText: "Tanggal Lahir",
                          textStyle:
                              TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(this.context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side:
                                        BorderSide(color: Colors.green[400]))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                LoginRequest request = LoginRequest();
                                request.username = loginUserNameController.text;
                                request.tanggalLahir =
                                    loginTanggalController.text;
                                request.password = loginUserNameController.text;
                                presenter.login(request);
                              }
                            }),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ));
      },
      presenter: AuthPresenter(AuthViewModel(), this),
    );
  }

  @override
  void saveAccount(LoginResponse loginResponse) {
    if (loginResponse.status == 200) {
      Pref.setUserLogin(loginResponse.data);

      Navigator.pop(this.context);
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
}
