import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_bloc.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';

import '../bloc/product_list_event.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProductListBloc>().add(ProductListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductListFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is ProductListSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("No products available."),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('Quantity: ${product.quantity}'),
                  ),
                );
              },
            );
          }
          // Default case (initial state).
          return const Center(
            child: Text("Loading..."),
          );
        },
      ),
    );
  }
}