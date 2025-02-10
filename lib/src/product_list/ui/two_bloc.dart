// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_bloc.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';
//
// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});
//
//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }
//
// class _ProductListScreenState extends State<ProductListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Trigger events to fetch data for both BLoCs
//     context.read<ProductListBloc>().add(const ProductListRequested());
//     context.read<CategoryBloc>().add(const CategoryRequested());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text(
//           'Product Catalog',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//       ),
//       body: Column(
//         children: [
//           BlocBuilder<CategoryBloc, CategoryState>(
//             builder: (context, categoryState) {
//               if (categoryState is CategoryLoading) {
//                 return const  Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: LinearProgressIndicator(),
//                 );
//               } else if (categoryState is CategorySuccess) {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: categoryState.categories.map((category) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Chip(
//                           label: Text(category.name),
//                           backgroundColor: Colors.blue,
//                           labelStyle: const TextStyle(color: Colors.white),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 );
//               } else if (categoryState is CategoryFailure) {
//                 return Center(
//                   child: Text(
//                     categoryState.errorMessage,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//
//           // Display Product Data
//           Expanded(
//             child: BlocBuilder<ProductListBloc, ProductListState>(
//               builder: (context, productListState) {
//                 if (productListState is ProductListLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (productListState is ProductListFailure) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.error_outline,
//                           color: Colors.red,
//                           size: 60,
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           productListState.errorMessage,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<ProductListBloc>().add(const ProductListRequested());
//                           },
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (productListState is ProductListSuccess) {
//                   if (productListState.products.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.inventory_2_outlined,
//                             size: 80,
//                             color: Colors.grey[400],
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'No products available',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     padding: const EdgeInsets.all(5.0),
//                     itemCount: productListState.products.length,
//                     itemBuilder: (context, index) {
//                       final product = productListState.products[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 5),
//                         child: ListTile(
//                           leading: CachedNetworkImage(
//                             imageUrl: product.productImage,
//                             placeholder: (context, url) => const CircularProgressIndicator(),
//                             errorWidget: (context, url, error) => const Icon(Icons.error_outline),
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                           title: Text(product.name),
//                           subtitle: Text('\$${product.salesRate}'),
//                           onTap: () {
//                             Fluttertoast.showToast(msg: product.name);
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return const Center(child: Text('Something went wrong'));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }