import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/login/bloc/login_bloc.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          const Center(
            child: Text('Some error occurred'),
          );
        }
        if (state is LoginSuccess) {
          Fluttertoast.showToast(msg: "Success");
          //Navigate
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product List'),
          ),
          body: Column(
            children: [
              Text('Data1'),
              Text('Data1'),
              Text('Data1'),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Bootstrap.house_add),
              label: Text('Add Product')),
        );
      },
    );
  }
}

//
// const Card(
// child: Column(
// children: [ListTile(
// title: Text('Product Name'),
// subtitle: Text('Sub Group'),
// leading: Icon(Bootstrap.ladder),
// )],
// ),
// );
