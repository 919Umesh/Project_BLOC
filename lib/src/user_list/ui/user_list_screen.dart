import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_bloc/app/routes/route_name.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';

import '../../../core/widgets/custom_dropdown.dart';
import '../../product_list/model/product_list_model.dart';
import '../model/product_list.dart';

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


  final List<ProductList> products = [
    ProductList(id: "1", name: "Laptop"),
    ProductList(id: "2", name: "Phone"),
    ProductList(id: "3", name: "Headphones"),
    ProductList(id: "4", name: "Tab"),
    ProductList(id: "5", name: "Iphone"),
    ProductList(id: "6", name: "Speaker"),
  ];

  // void _showDropDown(BuildContext context) {
  //   DropDownState<String>(
  //     dropDown: DropDown<String>(
  //       data: <SelectedListItem<String>>[
  //         SelectedListItem<String>(data: 'Tokyo'),
  //         SelectedListItem<String>(data: 'New York'),
  //         SelectedListItem<String>(data: 'London'),
  //       ],
  //       onSelected: (selectedItems) {
  //         List<String> list = selectedItems.map((item) => item.data).toList();
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Selected: ${list.join(", ")}"),
  //           ),
  //         );
  //       },
  //     ),
  //   ).showModal(context);
  // }

  void _showDropDown(BuildContext context) {
    List<SelectedListItem<String>> dropdownItems = products
        .map((product) => SelectedListItem<String>(data: product.name))
        .toList();

    CustomDropDown.show(
      context: context,
      items: dropdownItems,
      onSelected: (selectedItems) {
        Fluttertoast.showToast(
          msg: "Selected: ${selectedItems.join(", ")}",
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        );
      },
    );
  }

  void _showBottomModalSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Select an Option",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.location_city, color: Colors.blueAccent),
                    title: Text(
                      "Tokyo",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "Selected: Tokyo");
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  ListTile(
                    leading: Icon(Icons.location_city, color: Colors.green),
                    title: Text(
                      "New York",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "Selected: New York");
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  ListTile(
                    leading: Icon(Icons.location_city, color: Colors.redAccent),
                    title: Text(
                      "London",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "Selected: London");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Users",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.userListLocal);
            },
            icon: const Icon(Bootstrap.house),
          ),
          IconButton(
            onPressed: () => _showDropDown(context),// Open dropdown on button press
            icon: const Icon(Icons.filter_list), // Filter icon for dropdown
          ),
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
                return _buildEmptyState();
              }
              return _UserListView(userList: state.users);
            }
            return const Center(child: Text("No data"));
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied, size: 50, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No users found",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<UserListBloc>().add(LoadUsersRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
}


class _UserListView extends StatelessWidget {
  final List<UserModel> userList;

  const _UserListView({required this.userList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
                '${user.name.toLowerCase()}@example.com',
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
