import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: BlocListener<UserListBloc,UserListState>(
        listener: (context,state){
          if(state is UserListLoadError){
            Fluttertoast.showToast(msg: state.errorMessage);
          }
        },
        child: BlocBuilder<UserListBloc,UserListState>(
          builder: (context,state){
            if(state is UserListLoading){
              const Center(child: CircularProgressIndicator(),);
            }
            if(state is UserListLoadSuccess){
              if(state.users.isEmpty){
                Center(child: Text('No Product found'),);
              }
              return Card(
                elevation: 3.0,
                color: Colors.red,
                child: ListTile(
                  title: Text(''),
                  subtitle: Text(''),
                  leading: Icon(Icons.add),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
