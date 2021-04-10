import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medis/api/config/apisettings.dart';
import 'package:medis/api/medis/Activity_service.dart';
import 'package:medis/model/response/activity_response.dart';
import 'package:medis/model/response/base_response.dart';
import 'package:medis/view/activity/pattern/activity_view_interface.dart';
import 'package:medis/view/activity/pattern/activity_view_model.dart';
import 'package:mvvm_builder/mvvm_builder.dart';

class ActivityPresenter
    extends Presenter<ActivityViewModel, ActivityViewInterface> {
  ActivityPage page;

  ActivityPresenter(
      ActivityViewModel model, ActivityViewInterface view, ActivityPage page)
      : super(model, view) {
    this.page = page;
  }

  @override
  Future onInit() async {
    switch (this.page) {
      case ActivityPage.ACTIVITY:
        getActivity();
        break;
    }
    this.refreshView();
  }

  Future<void> getActivity() async {
    EasyLoading.show(status: 'Loading...');

    await ActivityService.getActivity().then((value) {
      if (value is ActivityResponse) {
        if (value.status == 200) {
          this.viewModel.activityResponse = value;
          this.viewInterface.showActivity(value);
        }
      } else if (value is BaseResponse) {
        viewInterface.showMessage(value.message, true);
      } else {
        viewInterface.showMessage(APiSettings.errorMsg, true);
      }

      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    });
  }
}

enum ActivityPage { ACTIVITY }
