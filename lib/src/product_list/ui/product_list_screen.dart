import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/app/app.dart';
import 'package:project_bloc/src/product_list/ui/update_product.dart';
import 'package:shimmer/shimmer.dart';
import '../../create_product/create_product.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductListBloc>().add(ProductListRequested());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<ProductListBloc>().add(ProductListLoadMoreRequested());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              return Text(
                state.products.isNotEmpty ? "Product" : "No Products",
                style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w800,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createProductScreenPath);
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              return const Text(
                'Add Products',
                style: TextStyle(color: Colors.white, fontFamily: 'inter'),
              );
            }
            if (state is ProductListFailure) {
              return const Text(
                'Failure',
                style: TextStyle(color: Colors.white, fontFamily: 'inter'),
              );
            }
            return const SizedBox.shrink();
          },
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
                    onPressed: () {
                      context
                          .read<ProductListBloc>()
                          .add(ProductListRequested());
                    },
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
                      'No products',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first product using the button below',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
            memCacheWidth: 800,
            memCacheHeight: 800,
            maxWidthDiskCache: 1200,
            maxHeightDiskCache: 1200,
            placeholder: (context, url) => buildShimmerEffect(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error_outline),
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          children: [
            Text(
              product.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
                onPressed: () {
                  FlutterClipboard.copy(product.name).then((value) =>
                      Fluttertoast.showToast(msg: 'Copied: ${product.name}'));
                },
                icon: const Icon(Bootstrap.copy))
          ],
        ),
        subtitle: Text(
          '\$${product.salesRate.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.createProductScreenPath,arguments:<String,dynamic> {
              "is_editing":true,
            });
          },
          icon: const Icon(Bootstrap.arrow_right),
        ),
      ),
    );
  }

  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
