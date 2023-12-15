import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {

  bool getCancelledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCancelledTaskList() async {
    getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelledTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCancelledTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: SafeArea(
          child: Column(
            children: [
              ProfileSummaryCard(),
              Expanded(
                child: Visibility(
                  visible: getCancelledTaskInProgress == false,
                  replacement:
                  const Center(child: const CircularProgressIndicator()),
                  child: taskListModel.taskList != null
                      ? RefreshIndicator(
                    onRefresh: getCancelledTaskList,
                    child: ListView.builder(
                      itemCount: taskListModel.taskList!.length,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: (){
                            getCancelledTaskList();
                          },

                          showProgress: (inCancelled) {
                            getCancelledTaskInProgress = inCancelled;
                            if(mounted){
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  )
                      : const Center(child: Text('No tasks available')),
                ),
              ),
            ],
          ),
        ));
  }
}
