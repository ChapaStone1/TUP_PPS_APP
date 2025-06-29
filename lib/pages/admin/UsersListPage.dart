import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/admin/UserList.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: UserList(),
      ),
    );
  }
}
