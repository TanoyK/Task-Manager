import 'package:flutter/material.dart';
import 'package:task_manager_11/data/models/network_response.dart';
import 'package:task_manager_11/data/models/task_list_model.dart';
import 'package:task_manager_11/data/services/network_caller.dart';
import 'package:task_manager_11/data/utils/urls.dart';
import 'package:task_manager_11/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_11/ui/widgets/task_list_tile.dart';
import 'package:task_manager_11/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool _getCompletedTaskInProgress = false,
      _getNewTaskInProgress = true;
  TaskListModel _taskListModel = TaskListModel();


  Future<void> getInCompletedTask() async {
    _getCompletedTaskInProgress= true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.inCompletedTask);
    if(response.isSuccess){
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("In completed tasks get failed")));
      }
    }
    _getCompletedTaskInProgress = false;
    if(mounted){
      setState(() { });
    }
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Summary data get failed")));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {

      });
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
        Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {

        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInCompletedTask();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileAppBar(
              isUpdateScreen: false,
            ),
            Expanded(
              child: _getCompletedTaskInProgress ? const Center(
                  child: CircularProgressIndicator()
              )
                  :ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListTile(
                    data: _taskListModel.data![index],
                    onDeleteTap: () {
                      deleteTask(_taskListModel.data![index].sId!);
                    },
                    onEditTap: () {
                      showStatusUpdateBottomSheet(_taskListModel.data![index]);
                    },
                  );
                  // return const TaskListTile();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 4.0,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    List<String> taskStatusList = ['new', 'progress', 'cancel', 'completed'];
    String _selectedTask = task.status!.toLowerCase();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: (){
          getNewTask();
        });
      },
    );
  }
}
