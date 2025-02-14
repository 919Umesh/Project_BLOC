// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
//
// class UserListLocal extends StatefulWidget {
//   const UserListLocal({super.key});
//
//   @override
//   State<UserListLocal> createState() => _UserListLocalState();
// }
//
// class _UserListLocalState extends State<UserListLocal> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserListBloc,UserListState>(listener: (context,state){
//       if(state is UserListLoadError){
//
//       }
//       if(state is UserNameLoadSuccess){
//
//       }
//     },
//     builder: (context,state){
//       return ListView.builder(
//         itemCount: stat,
//       );
//     },);
//   }
// }
