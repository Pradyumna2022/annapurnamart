import 'package:flutter/material.dart';

import '../app_lang.dart';
import '../custom_ui/common_appbar.dart';

class ProfileNotification extends StatefulWidget {
  const ProfileNotification({super.key});

  @override
  State<ProfileNotification> createState() => _ProfileNotificationState();
}

class _ProfileNotificationState extends State<ProfileNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(
          title: 'Notification', context: context,),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
