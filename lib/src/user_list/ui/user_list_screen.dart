import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/app/themes/colors.dart';
import 'package:project_bloc/core/core.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
   context.read<UserListBloc>().add(LoadUsersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},icon: Icon(Bootstrap.house_add), label: Text('Add Product')),
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: BlocListener<UserListBloc, UserListState>(
        listener: (context, state) {

          if (state is UserListLoadError) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListLoading) {
              return LoadingScreen().show();
            }
            if (state is UserListLoadSuccess) {
              if (state.users.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.sentiment_dissatisfied, size: 50),
                      const SizedBox(height: 10),
                      const Text("No users found"),
                      ElevatedButton(
                        onPressed: () {
                          context.read<UserListBloc>().add(LoadUsersRequested());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }
              return _ProductGroupView(userList: state.users);
            }
            if (state is UserListLoadError) {
              // Show an error message
              return Center(child: Text(state.errorMessage));
            }
            return const Center(child: Text("No data found"));
          },
        ),
      ),
    );
  }
}

class _ProductGroupView extends StatelessWidget {
  final List<UserModel> userList;

  const _ProductGroupView({required this.userList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        final user = userList[index];
        return InkWell(
          onTap: () {
            Fluttertoast.showToast(
              msg: user.name,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            );
          },
          child: Container(
            color: index % 2 == 0 ? kPrimaryColor.withOpacity(.2) : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(user.name),
                ),
                const Flexible(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}