import 'package:task_manager/ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseurl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseurl/registration';
  static const String login = '$_baseurl/login';
  static const String createNewTask = '$_baseurl/createTask';
  static const String getTaskStatusCount = '$_baseurl/taskStatusCount';
  static  String getNewTasks = '$_baseurl/listTaskByStatus/${TaskStatus.New.name}';
  static  String getProgressTasks = '$_baseurl/listTaskByStatus/${TaskStatus.Progress.name}';
  static  String getCompletedTasks = '$_baseurl/listTaskByStatus/${TaskStatus.Completed.name}';
  static  String getCancelledTasks = '$_baseurl/listTaskByStatus/${TaskStatus.Cancelled.name}';
  static String updateTaskStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';
  static const String updateProfile = '$_baseurl/profileUpdate';


}
