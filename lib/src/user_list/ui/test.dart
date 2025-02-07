import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocListener<UserListBloc,UserListState>(
        listener: (context,state){

        },
        child: BlocBuilder<UserListBloc,UserListState>(
          builder: (context,state){
            return Text('dg');
          },
        ),
      ),
    );
  }
}
