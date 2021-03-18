import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medis/utilities/dashboard_menu.dart';
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
        child: ListView(
          children: [
            SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10)),
              items: imageSliders,
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.lightGreen[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: ListTile(
                    leading: Container(
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text("Nurika Dewi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: Text("Pilihan menu",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            getGridView()
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
                leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.lime[200],
                      child: Image.asset(
                        menus[index].icon,
                        fit: BoxFit.contain,
                        width: 40,
                        height: 40,
                      ),
                    )),
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
