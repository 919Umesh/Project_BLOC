import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';

class UserListLocal extends StatefulWidget {
  const UserListLocal({super.key});

  @override
  State<UserListLocal> createState() => _UserListLocalState();
}

class _UserListLocalState extends State<UserListLocal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: BlocListener<UserListBloc,UserListState>(
        listener: (context,state){
          if(state is UserNameLoadError){
            Fluttertoast.showToast(msg: state.nameErrorMessage);
          }
        },
      ),
    );
  }
}
