import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medis/utilities/dashboard_menu.dart';
import 'package:medis/widgets/widget_header_inner.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DashboardMenu> menus = menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            HeaderInner(),
            ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 1.6,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text("Pilihan menu",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                getGridView(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Text("Gallery",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.width / 3),
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 10)),
                  items: imageSliders(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getGridView() {
    return Container(
      alignment: Alignment.topCenter,
      child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: menus.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width / 2) / 80),
          itemBuilder: (BuildContext context, int index) {
            index = index;
            return createTile(index, menus[index].title);
          }),
    );
  }

  Widget createTile(int index, String title) {
    return GestureDetector(
      onTap: () {
        callOnTapMenu(index);
      },
      child: IntrinsicHeight(
        child: Card(
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: ListTile(
                leading: Image.asset(
                  menus[index].icon,
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
                title: Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54))),
          ),
        ),
      ),
    );
  }

  void callOnTapMenu(index) {
    if (menus[index].directTo == null) {
      Toast.show(
        'Fitur sedang dalam tahap pengembangan',
        context,
        backgroundColor: Colors.red,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => menus[index].directTo));
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
