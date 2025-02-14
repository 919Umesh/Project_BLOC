import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import '../model/user_list_model.dart';

class UserListLocal extends StatefulWidget {
  const UserListLocal({super.key});

  @override
  State<UserListLocal> createState() => _UserListLocalState();
}

class _UserListLocalState extends State<UserListLocal> {
  @override
  void initState() {
    super.initState();
   context.read<UserListBloc>().add(UserNameRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: BlocListener<UserListBloc, UserListState>(
        listener: (context, state) {
          if (state is UserNameLoadError) {
            Fluttertoast.showToast(msg: state.nameErrorMessage);
          }
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserNameLoading) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserNameLoadSuccess) {
              if (state.userList.isEmpty) {
                const Center(
                  child: Text('No User Found'),
                );
              }
              return _UserListTile(userList: state.userList);
            }
            return const Text('Some error occurred');
          },
        ),
      ),
    );
  }
}

class _UserListTile extends StatelessWidget {
  final List<UserModel> userList;

  const _UserListTile({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}
