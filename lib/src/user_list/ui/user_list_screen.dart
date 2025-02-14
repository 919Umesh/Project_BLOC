import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../../../app/routes/route_name.dart';

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
    Fluttertoast.showToast(msg: "Rebuild");
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.blue[600],
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: const Text('Add User', style: TextStyle(color: Colors.white)),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Icon(Icons.list_rounded, color: Colors.blue[600]),
            const SizedBox(width: 12),
            const Text(
              "Users",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.userListLocal);
              },
              icon: const Icon(Bootstrap.house_add)),
        ],
      ),
      body: BlocListener<UserListBloc, UserListState>(
        listener: (context, state) {
          if (state is UserListLoadError) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        child: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserListLoadSuccess) {
              if (state.users.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sentiment_dissatisfied,
                          size: 50, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        "No users found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<UserListBloc>()
                              .add(LoadUsersRequested());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }
              return _UserListView(userList: state.users);
            }
            return const Center(child: Text("No data found"));
          },
        ),
      ),
    );
  }
}

class _UserListView extends StatelessWidget {
  final List<UserModel> userList;

  const _UserListView({required this.userList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.separated(
          itemCount: userList.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final user = userList[index];
            return ListTile(
              onTap: () {
                Fluttertoast.showToast(
                  msg: user.name,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                );
              },
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  user.name[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'user@example.com',
                // Add email field to your UserModel if needed
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'User', // Add role field to your UserModel if needed
                  style: GoogleFonts.poppins(
                    color: Colors.blue[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
