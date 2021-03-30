import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderInner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            color: Colors.green[400],
            child: Center(
              child: ListTile(
                  leading: Container(
                    child: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text("(Tamu) Pasien",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50.0)),
                color: Colors.green[400],
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "MIRAI MEDIS",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Mobile Information System of \nRSUD Arifin Achmad Pekanbaru",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    bottom: 50,
                    left: 20,
                  ),
                  Positioned(
                    child: Image.asset("assets/images/rsud-ilus.png",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2),
                    bottom: 0,
                    top: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(child: Container(), flex: 2)
        ],
      ),
    );
  }
}
