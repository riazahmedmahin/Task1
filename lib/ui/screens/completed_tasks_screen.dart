import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

import '../../data/models/task_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {

  bool getCompletedTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getCompletedTaskList() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompletedTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompletedTaskList();
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
                  visible: getCompletedTaskInProgress == false,
                  replacement:
                  const Center(child: const CircularProgressIndicator()),
                  child: taskListModel.taskList != null
                      ? RefreshIndicator(
                    onRefresh: getCompletedTaskList,
                    child: ListView.builder(
                      itemCount: taskListModel.taskList!.length,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: (){
                            getCompletedTaskList();
                          },
                          showProgress: (inCompleted) {
                            getCompletedTaskInProgress = inCompleted;
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
