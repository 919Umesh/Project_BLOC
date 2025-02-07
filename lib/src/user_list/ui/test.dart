import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Product"),
      ),
      body: BlocListener<UserListBloc,UserListState>(
        listener: (context,state){},
        child: BlocBuilder<UserListBloc,UserListState>(
          builder: (context,state){
            return const Text('fg');
          },
        ),
      ),
    );
  }
}
