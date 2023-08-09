import 'package:flutter/material.dart';
import 'package:task_manager_11/data/models/auth_utility.dart';
import 'package:task_manager_11/ui/screens/auth/login_screen.dart';
import 'package:task_manager_11/ui/screens/update_profile_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final bool isUpdateScreen;
  const UserProfileBanner({
    super.key, required this.isUpdateScreen,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()
            ));
          }
        },
        child: Row(
          children: [
             Visibility(
               visible: (widget.isUpdateScreen ?? false) == false,
               child: Row(
                 children: [
                   CircleAvatar(
                    backgroundImage: NetworkImage(
                      AuthUtility.userInfo.data?.photo ?? '',
                    ),
                    onBackgroundImageError: (_, __){
                      const Icon(Icons.image);
                    },
                    // 'https://images.unsplash.com/photo-1519709042477-8de6eaf1fdc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1227&q=80'),
                    radius: 15,
            ),
            const SizedBox(width: 16,),
                 ],
               ),
             ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.firstName ?? ''}",
                  style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                ),
              Text(
                AuthUtility.userInfo.data?.email ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              ],
            ),
          ],
        ),
      ),

      actions: [
          IconButton(
            onPressed: () async {
             await AuthUtility.clearUserInfo();
             if(mounted) {
               Navigator.pushAndRemoveUntil(context,
                   MaterialPageRoute(builder: (context) => const LoginScreen()),
                       (route) => false);
             }
             },
            icon: const Icon(Icons.logout),
          ),
        ],
    );
  }
}
