import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/app/routes/route_name.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAndLoadData();
    });
  }
  Future<void> _fetchAndLoadData() async {
    context.read<UserListBloc>().add(LoadUsersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (BuildContext context, state) {
        if (state is UserListLoadSuccess) {}
        if (state is UserListLoadError) {
        } else {}
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Users"),actions: [
            IconButton(onPressed: ()
            {
              Navigator.pushNamed(context, AppRoute.accountGroupScreenPath);
            }, icon: const Icon(Bootstrap.list))
          ],),
          body: BlocBuilder<UserListBloc, UserListState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (BuildContext context, state) {
              if (state is UserListLoading) {
                return LoadingScreen().show();
              }
              if (state is UserListLoadSuccess) {
                return _ProductGroupView(userList: state.users);
              }
              if (state is UserListLoadError) {
                return Text(state.errorMessage);
              }
              return const Center(child: Text("No data found"));
            },
          ),
        );
      },
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
      itemBuilder: (BuildContext context, int index) {
        UserModel userName = userList[index];
        return InkWell(
          onTap: (){
            Fluttertoast.showToast(msg: userName.name);
          },
          child: Container(
            color: index % 2 == 0 ? kPrimaryColor.withOpacity(.2) : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: Text(userName.name)),
                const Flexible(child: Icon(Icons.arrow_forward_ios_rounded))
              ],
            ).paddingSymmetric(20.0, 15.0),
          ),
        );
      },
    );
  }
}
