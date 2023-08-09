import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_11/ui/screens/auth/login_screen.dart';
import 'package:task_manager_11/ui/widgets/screen_background.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                Text('Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text('Minimum password should be a letters with number and symbols',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                const TextField(
                  obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    )
                ),

                const SizedBox(height: 16,),

                const TextField(
                  obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    )
                ),

                const SizedBox(height: 16,),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) =>
                      const LoginScreen()), (route)=> false);
                    } ,
                        child: const Text('Confirm'),
                    ),
                ),

                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account?", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5
                    ),),
                    TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) =>
                          const LoginScreen()), (route)=> false);
                    },
                        child: const Text('Sign in')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
