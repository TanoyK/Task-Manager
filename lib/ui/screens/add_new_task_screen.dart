import 'package:flutter/material.dart';
import 'package:task_manager_11/data/models/network_response.dart';
import 'package:task_manager_11/data/services/network_caller.dart';
import 'package:task_manager_11/data/utils/urls.dart';
import 'package:task_manager_11/ui/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async{
    _addNewTaskInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
    "description": _descriptionTEController.text.trim(),
    "status":"New"
  };
    final NetworkResponse response = await
      NetworkCaller().postRequest(Urls.createTask, requestBody );
    _addNewTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task added successfully')));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task add failed')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileAppBar(
              isUpdateScreen: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  Text('Add new task',
                    // style: TextStyle(
                    // fontSize: 30,
                    // fontWeight: FontWeight.w400,
                    // color: Colors.black,

                    // ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16,),
                   TextFormField(
                     controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title'
                    ),
                     validator: (String? value ){
                       if(value?.isEmpty ?? true){
                         return 'Enter your title';
                       }
                       return null;
                     },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: 'Description'
                    ),
                    validator: (String? value ){
                      if(value?.isEmpty ?? true){
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _addNewTaskInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                            onPressed: (){
                              addNewTask();
                        } ,
                            child: const Icon(Icons.arrow_forward_ios)),
                      )
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
