import 'package:flutter/material.dart';

class Pesan extends StatefulWidget {
  Pesan({Key key}) : super(key: key);

  @override
  _PesanState createState() => _PesanState();
}

class _PesanState extends State<Pesan> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
