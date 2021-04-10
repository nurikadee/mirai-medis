import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:medis/model/response/activity_response.dart';
import 'package:medis/view/activity/pattern/activity_presenter.dart';
import 'package:medis/view/activity/pattern/activity_view_interface.dart';
import 'package:medis/view/activity/pattern/activity_view_model.dart';
import 'package:medis/widgets/item_activity.dart';
import 'package:mvvm_builder/mvvm_builder.dart';
import 'package:toast/toast.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with ActivityViewInterface, LifecycleAware, LifecycleMixin {
  ActivityResponse activityResponse;

  ActivityPresenter presenter;

  Widget listData = Container();

  int get count => list.length;

  List<Activity> list = <Activity>[];

  bool isFinish = false;

  @override
  Widget build(BuildContext context) {
    if (activityResponse != null) {
      listData = Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: list.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctxt, int index) {
                return ItemActivity(
                    activity: list[index], presenter: presenter);
              }));
    }

    return MVVMPage<ActivityPresenter, ActivityViewModel>(
      builder: (context, presenter, model) {
        this.presenter = presenter;
        return Scaffold(
            appBar: AppBar(title: Text("Riwayat Aktifitas Pasien")),
            body: RefreshIndicator(
                onRefresh: () {
                  return _refresh(presenter);
                },
                child: listData));
      },
      presenter:
          ActivityPresenter(ActivityViewModel(), this, ActivityPage.ACTIVITY),
    );
  }

  Future<void> _refresh(ActivityPresenter presenter) async {
    await presenter.getActivity();
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
  void showMessage(String message, bool error) async {
    if (!error) {
      await presenter.getActivity();
    }
    Toast.show(
      message,
      context,
      backgroundColor: error ? Colors.red : Colors.yellow[800],
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }

  @override
  void showActivity(ActivityResponse activityResponse) {
    print("load");
    setState(() {
      if (this.list != null) this.list.clear();

      this.activityResponse = activityResponse;
      this.list = activityResponse.data;

      DateFormat format = DateFormat("yyyy-MM-dd");

      list.sort((a, b) => format
          .parse(b.tanggalPendaftaran)
          .compareTo(format.parse(a.tanggalPendaftaran)));
    });
  }
}
