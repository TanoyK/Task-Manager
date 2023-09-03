import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_11/data/models/network_response.dart';
import 'package:task_manager_11/data/services/network_caller.dart';
import 'package:task_manager_11/data/utils/urls.dart';
import 'package:task_manager_11/ui/screens/auth/login_screen.dart';
import 'package:task_manager_11/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager_11/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager_11/ui/widgets/screen_background.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _otpVerificationInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> verifyOtp()async{
    _otpVerificationInProgress = true;
    if(mounted){
      setState(() { });
    }
    final NetworkResponse response = await
    NetworkCaller().getRequest(Urls.otpVerify(widget.email, _otpTEController.text));
    _otpVerificationInProgress = false;
    if(mounted){
      setState(() { });
    }

    if(response.body!['status'] == 'success') {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                ResetPasswordScreen(
                    email: widget.email, otp: _otpTEController.text)));

    }
    } else{
      if(mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
            const SnackBar(content: Text('Otp verification has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 64),
                    Text('PIN verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text('A 6 digit verification pin will send to your email address',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PinCodeTextField(
                      controller: _otpTEController,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      validator: (String? value ){
                      if(value?.isEmpty ?? true){
                      return 'Enter your correct Otp';

                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.red,
                        activeColor: Colors.white,
                        selectedColor: Colors.green,
                        selectedFillColor: Colors.white,
                        activeFillColor: Colors.white,

                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      cursorColor: Colors.green,
                      enablePinAutofill: true,
                      onCompleted: (v) {

                      },
                      onChanged: (value) {

                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },appContext: context,
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _otpVerificationInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                        verifyOtp();
                                      }
                                      else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Otp verification failed')));

                                      }

                                    },
                              child: const Text('Verify')
                          ),
                        ),
                    ),


                            const SizedBox(height: 16,),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                     const Text("Have an account?", style: TextStyle(
                     fontWeight: FontWeight.w500,
                     letterSpacing: 0.5
                      ),
                     ),
                      TextButton(onPressed: (){
                          Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) =>
                          const LoginScreen()), (route)=> false);
                          },
                         child: const Text('Sign in')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
