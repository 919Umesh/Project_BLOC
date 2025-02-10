// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_bloc.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';
// import 'package:project_bloc/src/product_list/ui/product_details.dart';
// import '../../../app/routes/route_name.dart';
// import '../bloc/product_list_event.dart';
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
//     context.read<ProductListBloc>().add(const ProductListRequested());
//   }
//
//   final bool _isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.pushNamed(context, AppRoute.createProductScreenPath);
//         },
//         icon: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         label: const Text(
//           'Add Product',
//           style: TextStyle(color: Colors.white, fontFamily: 'inter'),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
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
//       body: BlocBuilder<ProductListBloc, ProductListState>(
//         builder: (context, state) {
//           if (state is ProductListLoading) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const CircularProgressIndicator(),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Loading Products...',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is ProductListFailure) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     state.errorMessage,
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<ProductListBloc>()
//                           .add(const ProductListRequested());
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is ProductListSuccess) {
//             if (state.products.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.inventory_2_outlined,
//                       size: 80,
//                       color: Colors.grey[400],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'No products available',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Add your first product using the button below',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return ListView.builder(
//               padding: const EdgeInsets.all(5.0),
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return AnimatedContainer(
//                   height: _isExpanded ? 200 : 150,
//                   width: _isExpanded ? 200 : 150,
//                   duration: const Duration(milliseconds: 500),
//                   margin: const EdgeInsets.only(bottom: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(16),
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetailScreen(
//                               name: product.name,
//                               salesRate: product.salesRate.toString(),
//                               productImage: product.productImage,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Hero(
//                               tag: 'product-${product.productImage}',
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: CachedNetworkImage(
//                                   imageUrl: product.productImage,
//                                   placeholder: (context, url) => Container(
//                                     width: 100,
//                                     height: 100,
//                                     color: Colors.grey[200],
//                                     child: const Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Container(
//                                     width: 100,
//                                     height: 100,
//                                     color: Colors.grey[200],
//                                     child: const Icon(
//                                       Icons.error_outline,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     product.name,
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black87,
//                                       fontFamily: 'inter',
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.inventory_2_outlined,
//                                         size: 16,
//                                         color: Colors.grey,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         '${product.quantity} ${product.unit}',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey[600],
//                                           fontFamily: 'inter',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.attach_money,
//                                         size: 16,
//                                         color: Colors.grey,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         '\$${product.salesRate}',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           color: Theme.of(context).primaryColor,
//                                           fontFamily: 'inter',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.timer_outlined,
//                                         size: 16,
//                                         color: Colors.grey,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         product.duration,
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey[600],
//                                           fontFamily: 'inter',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 16,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: () {
//                                 Fluttertoast.showToast(msg: product.name);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.error_outline,
//                   size: 60,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Something went wrong',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/app/app.dart';
import 'package:project_bloc/src/product_list/ui/product_details.dart';

import '../bloc/product_list_bloc.dart';
import '../bloc/product_list_event.dart';
import '../bloc/product_list_state.dart';
import '../model/product_list_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialData() {
    context.read<ProductListBloc>().add(
      ProductListRequested(page: _currentPage, limit: _itemsPerPage),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = context.read<ProductListBloc>().state;
      if (state is ProductListSuccess && !state.hasReachedEnd) {
        _currentPage++;
        context.read<ProductListBloc>().add(
          ProductListRequested(page: _currentPage, limit: _itemsPerPage),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: 'dfgbfd');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Product Catalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //createProductScreenPath
          Navigator.pushNamed(context,AppRoute.createProductScreenPath);
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white, fontFamily: 'inter'),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductListFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadInitialData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductListSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No products available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first product using the button below',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length + (state.hasReachedEnd ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.products.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final product = state.products[index];
                return _buildProductItem(product);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
            imageUrl: product.productImage,
            placeholder: (context, url) => const SizedBox(
              width: 50,
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error_outline),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '\$${product.salesRate.toStringAsFixed(2)}',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                name: product.name,
                salesRate: product.salesRate.toString(),
                productImage: product.productImage,
              ),
            ),
          );
        },
      ),
    );
  }
}