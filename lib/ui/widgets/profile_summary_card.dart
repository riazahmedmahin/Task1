import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    Key? key, // Added 'Key? key'
    this.enableOnTap = true,
  }) : super(key: key); // Fixed the super constructor call
  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {



    return GetBuilder<AuthController>(

      builder: (authController) {
        String? base64Image = authController.user?.photo;
        Uint8List? imageBytes;
        imageBytes = base64Decode(base64Image!);
        return ListTile(
          onTap: () {
            if (enableOnTap == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return EditProfileScreen();
              }));
            }
          },
          leading: CircleAvatar(
            child: authController.user?.photo == null
                ? const Icon(Icons.person)
                : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: imageBytes != null
                  ? Image.memory(imageBytes!, fit: BoxFit.cover)
                  : const Icon(Icons.error), // Display an error icon or placeholder
            ),
          ),
          title: Text(
            fullName(authController),
            style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            authController.user?.email ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
              onPressed: () async {
                AuthController.clearAuthData();
                // solve this worning
                Get.offAll(const LoginScreen());
              },
              icon: Icon(Icons.logout)),
          tileColor: Colors.green,
        );
      }
    );
  }

  String  fullName(AuthController authController) {
    return '${authController.user?.firstName ?? ''} ${authController.user?.lastName ?? ''}';
  }
}
