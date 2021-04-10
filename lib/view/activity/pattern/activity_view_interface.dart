import 'package:medis/model/response/activity_response.dart';

abstract class ActivityViewInterface {
  void showMessage(String message, bool error);

  void showActivity(ActivityResponse activityResponse);
}
