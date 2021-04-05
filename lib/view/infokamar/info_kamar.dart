import 'package:flutter/material.dart';

class InfoKamar extends StatefulWidget {
  InfoKamar({Key key}) : super(key: key);

  @override
  _InfoKamarState createState() => _InfoKamarState();
}

class _InfoKamarState extends State<InfoKamar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Info Kamar")), body: Container());
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
