import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/core/core.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../bloc/user_list_bloc.dart';

class AccountGroupScreen extends StatefulWidget {
  const AccountGroupScreen({super.key});

  @override
  State<AccountGroupScreen> createState() => _AccountGroupScreenState();
}

class _AccountGroupScreenState extends State<AccountGroupScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserListBloc>().add(UserNameRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
        listener: (BuildContext context, state) {
      if (state is UserNameLoadSuccess) {}
      if (state is UserListLoadError) {
      } else {}
    }, builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Name'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Bootstrap.indent))
          ],
        ),
        body: BlocBuilder<UserListBloc, UserListState>(
          buildWhen: (previous, current) {
            return previous != current;
          },
          builder: (BuildContext context, state) {
            if (state is UserListLoading) {
              return LoadingScreen().show();
            }
            if (state is UserNameLoadSuccess) {
              return ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel users = state.userList[index];
                  return ListTile(
                    title: Text(users.name),
                  );
                },
              );
            }
            return const Center(
              child: Text('No Data found'),
            );
          },
        ),
      );
    });
  }
}
