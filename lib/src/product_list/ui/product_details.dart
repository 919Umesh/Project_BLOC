import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/app/app.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String salesRate;
  final String productImage;

  const ProductDetailScreen(
      {super.key,
      required this.name,
      required this.salesRate,
      required this.productImage});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Fluttertoast.showToast(msg: 'Product Added');
        },
        icon: const Icon(
          Bootstrap.person_add,
          color: Colors.white,
        ),
        label: const Text(
          'Add Product',
          style: TextStyle(fontFamily: 'inter', color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product-${widget.productImage}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.productImage,
                  memCacheWidth: 100,
                  memCacheHeight: 100,
                  maxWidthDiskCache: 400,
                  maxHeightDiskCache: 400,
                  placeholder: (context, url) => Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Product Name
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.attach_money,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  '\$${widget.salesRate}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Additional details about the product...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
