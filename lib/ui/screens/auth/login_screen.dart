import 'package:flutter/material.dart';
import 'package:task_manager_11/data/models/auth_utility.dart';
import 'package:task_manager_11/data/models/login_model.dart';
import 'package:task_manager_11/data/models/network_response.dart';
import 'package:task_manager_11/data/services/network_caller.dart';
import 'package:task_manager_11/data/utils/urls.dart';
import 'package:task_manager_11/ui/screens/auth/signup_screen.dart';
import 'package:task_manager_11/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_11/ui/widgets/screen_background.dart';
import '../email_verification_screen.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _loginInProgress = false;

  Future<void> login() async {
    _loginInProgress = true;
    if(mounted){
      setState(() {

      });
    }
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login, requestBody, isLogin: true);
    _loginInProgress = false;
    if(mounted){
      setState(() {

      });
    }

    if(response.isSuccess){
      LoginModel model = LoginModel.fromJson(response.body!);
        await AuthUtility.saveUserInfo(model);
        if(mounted) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>
              const BottomNavBaseScreen()), (route) => false);

        }
        }else{
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password')));
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const SizedBox(height: 64),
                     Text('Get Started',
                      // style: TextStyle(
                      // fontSize: 30,
                      // fontWeight: FontWeight.w400,
                      // color: Colors.black,

                    // ),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        ),
                      validator: (String? value ){
                        if(value?.isEmpty ?? true){
                          return 'Enter your email';

                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12,),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      validator: (String? value ){
                        if((value?.isEmpty ?? true) || value!.length <= 5){
                          return 'Enter a password more than 6 letter';

                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        replacement: const Center(
                          child: CircularProgressIndicator(),),
                        child: Visibility(
                          visible: _loginInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed: (){
                                   login();
                          } , child: const Icon(Icons.arrow_forward_ios)),
                        ),
                      )
                    ),

                    const SizedBox(height: 16,),
                    Center(
                        child: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const EmailVerificationScreen()));
                        },
                            child: const Text('Forget Password',
                              style: TextStyle(
                          color: Colors.grey,
                        ),))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5
                        ),),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              const SignUpScreen()));
                        }, child: const Text('Sign up')),
                      ],
                    )
                  ]
                ),
              ),
          ),
        ),
      ),

    );
  }
}



