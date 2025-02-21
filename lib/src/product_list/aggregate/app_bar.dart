import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../core/extensions/custom_icon_button.dart';
import '../model/product_list_model.dart';
import 'package:intl/intl.dart';

class AppBarPage extends StatefulWidget {
  final ProductModel product;

  const AppBarPage({super.key, required this.product});

  @override
  State createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.blue[400],
                leading: CircularIconButton(
                  icon: Bootstrap.chevron_left,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: 10.0,
                  backgroundColor: Colors.white,
                  iconColor: Colors.black,
                ),
                actions: [
                  CircularIconButton(
                    icon: Bootstrap.share,
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Share');
                    },
                    padding: 10.0,
                    backgroundColor: Colors.white,
                    iconColor: Colors.black,
                  ),
                  CircularIconButton(
                    icon: Bootstrap.heart,
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'Heart');
                    },
                    padding: 10.0,
                    backgroundColor: Colors.white,
                    iconColor: Colors.black,
                  ),
                ],
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double appBarHeight = constraints.maxHeight;
                    double opacity = 1.0 - ((appBarHeight - kToolbarHeight) / (200.0 - kToolbarHeight)).clamp(0.0, 1.0);
                    return FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      background: Hero(
                        tag: 'product-${product.id}',
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              product.productImage,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.3),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildInfoCard(
                        title: 'Product Details',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Name', product.name),
                            _buildDetailRow('Unit', product.unit),
                            _buildDetailRow(
                                'Quantity', product.quantity.toString()),
                            _buildDetailRow(
                              'Sales Rate',
                              '₹${product.salesRate.toStringAsFixed(2)}',
                            ),
                            _buildDetailRow(
                              'Purchase Rate',
                              '₹${product.purchaseRate.toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Duration Details',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              'Duration',
                              '${product.duration} days',
                            ),
                            _buildDetailRow(
                              'From Date',
                              DateFormat('MMM dd, yyyy')
                                  .format(product.fromDate),
                            ),
                            _buildDetailRow(
                              'To Date',
                              DateFormat('MMM dd, yyyy').format(product.toDate),
                            ),
                          ],
                        ),
                      ),
                      // _productCart(product.productImage, product.name,
                      //     product.salesRate.toString(), product.unit),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Additional Information',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              'Created At',
                              DateFormat('MMM dd, yyyy HH:mm')
                                  .format(product.createdAt),
                            ),
                            _buildDetailRow(
                              'Updated At',
                              DateFormat('MMM dd, yyyy HH:mm')
                                  .format(product.updatedAt),
                            ),
                            _buildDetailRow('Product ID', '#${product.id}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCart(
    String productImage,
    String productName,
    String salesRate,
    String unit,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              productImage,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name and Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onPressed: () {
                        // Add action here
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Unit and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          unit,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹$salesRate',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
