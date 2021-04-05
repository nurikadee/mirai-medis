import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/cache/pref.dart';
import 'package:medis/model/response/login_response.dart';
import 'package:medis/view/akun/login.dart';
import 'package:medis/view/splash/splash.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with LifecycleAware, LifecycleMixin {
  var isLoggedIn = false;

  DataUser dataUser;

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      checkIsLoggedIn();
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
  }

  void checkIsLoggedIn() {
    Pref.checkIsLoggedIn().then((seen) {
      setState(() {
        isLoggedIn = seen;
      });

      if (seen) {
        Pref.getUserLogin().then((value) => dataUser = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: TextStyle(color: Colors.grey[700])),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[100],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              isLoggedIn ? getUserDetail() : Container(),
              isLoggedIn ? Container() : getButtonLogin(),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.width / 5,
                      child: Center(
                        child: ListTile(
                            leading: Container(
                              child: Icon(
                                Icons.history,
                                size: 30,
                                color: Colors.grey[500],
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey[500],
                            ),
                            title: Text("Riwayat aktifitas",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle:
                                Text("Melihat aktifitas anda pada aplikasi",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ))),
                      ),
                    ),
                  )),
              isLoggedIn ? getButtonLogout() : Container(),
              Expanded(
                  child: Center(
                      child: Text("Mirai Medis v.$versionName",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ))))
            ],
          )),
    );
  }

  Widget getButtonLogin() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => Login(),
            ));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 5,
              padding: EdgeInsets.all(5),
              child: Center(
                child: ListTile(
                    leading: Container(
                      child: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.grey[500],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    title: Text("Masuk sebagai Pasien",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                        "Masuk menggunakan Nomor Rekam Medis atau Nomor Identitas (KTP / SIM / Paspor)",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ))),
              ),
            ),
          )),
    );
  }

  Widget getUserDetail() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Column(
                children: [
                  ListTile(
                      leading: Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 50,
                          color: Colors.grey[500],
                        ),
                      ),
                      title: Text(dataUser.pasien.nama,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle:
                          Text("No. Rekam Medis : ${dataUser.pasien.kode}",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ))),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/ic_blood.png",
                              width: 15,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  dataUser.pasien.goldar == null
                                      ? "-"
                                      : dataUser.pasien.goldar.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.cake,
                              size: 20,
                              color: Colors.grey[500],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(dataUser.pasien.tglLahir.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      )),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.remove_red_eye_sharp,
                              size: 20,
                              color: Colors.blue[500],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Lihat Detail",
                                  style: TextStyle(
                                    color: Colors.blue[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget getButtonLogout() {
    return InkWell(
      onTap: () {
        Pref.remove();

        checkIsLoggedIn();
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.red[400],
            child: Container(
              height: MediaQuery.of(context).size.width / 8,
              child: Center(
                child: ListTile(
                  title: Text("Keluar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          )),
    );
  }
}
