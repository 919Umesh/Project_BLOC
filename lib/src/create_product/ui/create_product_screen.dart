import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/image_picker.dart';
import '../../product_list/model/product_list_model.dart';
import '../bloc/create_product_bloc.dart';
import '../bloc/create_product_event.dart';
import '../bloc/create_product_state.dart';

class CreateProductScreen extends StatefulWidget {
  final bool isEditing;
  final ProductModel? productModel;

  const CreateProductScreen(
      {super.key, required this.isEditing, this.productModel});

  @override
  State createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKeyProduct = GlobalKey<FormBuilderState>();
  File? _imageFile;

  Widget _buildFormField({
    required String name,
    required String label,
    String? initialValue,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FormBuilderTextField(
        name: name,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: 'inter',
          ),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasProfile = (widget.productModel!.productImage.isNotEmpty);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          widget.isEditing ? 'Edit Product' : 'Create Product',
          style:
              const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'inter'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKeyProduct,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    hasProfile
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade200,
                            child: widget.productModel?.productImage != null &&
                                    widget.productModel!.productImage.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      memCacheWidth: 1000,
                                      memCacheHeight: 1000,
                                      maxWidthDiskCache: 2000,
                                      maxHeightDiskCache: 2000,
                                      imageUrl:
                                          widget.productModel!.productImage,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      // Loading indicator
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              size: 40, color: Colors.red),
                                      // Error icon
                                      width: 100,
                                      // Ensuring correct size inside CircleAvatar
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.person,
                                    size: 40,
                                    color: Colors.grey), // Default icon
                          )
                        : ImagePickerWidget(
                            onImageSelected: (file) {
                              setState(() {
                                _imageFile = file;
                              });
                            },
                          ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap to change product image',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'inter',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'inter',
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      name: 'name',
                      label: 'Product Name',
                      initialValue:
                          widget.isEditing ? widget.productModel!.name : null,
                      suffix: const Icon(Icons.inventory_2_outlined),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            name: 'salesRate',
                            label: 'Sales Rate',
                            initialValue: widget.isEditing
                                ? widget.productModel!.salesRate.toString()
                                : null,
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.attach_money),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            name: 'purchaseRate',
                            label: 'Purchase Rate',
                            initialValue: widget.isEditing
                                ? widget.productModel!.purchaseRate.toString()
                                : null,
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.shopping_cart_outlined),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            name: 'quantity',
                            label: 'Quantity',
                            initialValue: widget.isEditing
                                ? widget.productModel!.quantity.toString()
                                : null,
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.numbers),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            name: 'unit',
                            label: 'Unit',
                            initialValue: widget.isEditing
                                ? widget.productModel!.unit
                                : null,
                            suffix: const Icon(Icons.scale_outlined),
                          ),
                        ),
                      ],
                    ),
                    _buildFormField(
                      name: 'duration',
                      label: 'Duration',
                      initialValue: widget.isEditing
                          ? widget.productModel!.duration
                          : null,
                      suffix: const Icon(Icons.timer_outlined),
                    ),
                    const Text(
                      'Validity Period',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          FormBuilderDateTimePicker(
                            name: 'fromDate',
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            decoration: InputDecoration(
                              labelText: 'From Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderDateTimePicker(
                            name: 'toDate',
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            decoration: InputDecoration(
                              labelText: 'To Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocConsumer<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                        if (state is CreateProductSuccess) {
                          Fluttertoast.showToast(
                            msg: state.message,
                            backgroundColor: Colors.green,
                          );
                        } else if (state is CreateProductError) {
                          Fluttertoast.showToast(
                            msg: state.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: 56,
                          margin: const EdgeInsets.only(bottom: 24),
                          child: ElevatedButton(
                            onPressed: state is CreateProductLoading
                                ? null
                                : () async {
                                    if (_formKeyProduct.currentState
                                            ?.saveAndValidate() ??
                                        false) {
                                      final formData = d.FormData.fromMap({
                                        ..._formKeyProduct.currentState!.value,
                                        if (_imageFile != null)
                                          'productImage':
                                              await d.MultipartFile.fromFile(
                                                  _imageFile!.path),
                                      });
                                      widget.isEditing
                                          ? context
                                              .read<CreateProductBloc>()
                                              .add(UpdateProductRequested(
                                                  formData: formData,
                                                  id: widget.productModel!.id))
                                          : context
                                              .read<CreateProductBloc>()
                                              .add(CreateProductRequested(
                                                  formData: formData));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state is CreateProductLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    widget.isEditing
                                        ? 'Edit Product'
                                        : 'Create Product',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
