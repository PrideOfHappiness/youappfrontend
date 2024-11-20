import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement create/update profile
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Profile"),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton.filled(
              onPressed: () {
                // Implement create profile
              },
              child: const Text("Create Profile"),
            ),
            const SizedBox(height: 10),
            CupertinoButton.filled(
              onPressed: () {
                // Implement update profile
              },
              child: const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}