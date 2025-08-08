import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'features/product/domain/entities/product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/bloc/product_state.dart';
import 'injection_container.dart' as di;

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _image;
  Product? _existingProduct; // ✅ ADD THIS
  bool _isUpdateMode = false; // ✅ ADD THIS

  @override
  void didChangeDependencies() {
    // ✅ ADD THIS ENTIRE METHOD
    super.didChangeDependencies();

    // Check if we received a product (UPDATE mode)
    if (_existingProduct == null) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is Product) {
        _existingProduct = arguments;
        _isUpdateMode = true;
        _populateFields();
      }
    }
  }

  void _populateFields() {
    // ✅ ADD THIS ENTIRE METHOD
    if (_existingProduct != null) {
      _nameController.text = _existingProduct!.name;
      _priceController.text = _existingProduct!.price.toString();
      _descriptionController.text = _existingProduct!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProductBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            _isUpdateMode ? "Update Product" : "Add Product",
          ), // ✅ CHANGE THIS LINE
          actions: const [],
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            }

            if (state is ProductUpdated) {
              // ✅ ADD THIS ENTIRE BLOCK
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            }

            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ProductLoading;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => pickImage(),
                      child: Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _buildImageWidget(), // ✅ CHANGE THIS LINE
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        children: [
                          // ✅ Name field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  fillColor: const Color.fromARGB(
                                    255,
                                    207,
                                    206,
                                    206,
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Enter product name',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter product name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // ✅ Category field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Category",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _categoryController,
                                decoration: InputDecoration(
                                  fillColor: const Color.fromARGB(
                                    255,
                                    207,
                                    206,
                                    206,
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Enter category',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: const Color.fromARGB(
                                    255,
                                    207,
                                    206,
                                    206,
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Enter price',
                                  prefixText: '\$ ',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter price';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid price';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          // ✅ Description field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _descriptionController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  fillColor: const Color.fromARGB(
                                    255,
                                    207,
                                    206,
                                    206,
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Enter product description',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter description';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ✅ Dynamic button (ADD or UPDATE)
                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue[400]!, Colors.blue[600]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () => _submitProduct(
                                        context,
                                      ), // ✅ CHANGE THIS LINE
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child:
                                  isLoading
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _isUpdateMode
                                                ? "Updating..."
                                                : "Adding...", // ✅ CHANGE THIS LINE
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                      : Text(
                                        _isUpdateMode
                                            ? "UPDATE"
                                            : "ADD", // ✅ CHANGE THIS LINE
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ✅ CLEAR button
                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: _clearForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "CLEAR",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ✅ ADD THIS ENTIRE METHOD
  Widget _buildImageWidget() {
    if (_image != null) {
      // Show newly selected image
      return Image.file(_image!, width: 300, height: 150, fit: BoxFit.cover);
    } else if (_isUpdateMode && _existingProduct!.imageUrl.isNotEmpty) {
      // Show existing network image in update mode
      return Image.network(
        _existingProduct!.imageUrl,
        width: 300,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
              SizedBox(height: 10),
              Text("Tap to change image"),
            ],
          );
        },
      );
    } else {
      // Show placeholder
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 70, color: Colors.grey),
          SizedBox(height: 10),
          Text("Upload image"),
        ],
      );
    }
  }

  // ✅ REPLACE _addProduct METHOD WITH THIS
  void _submitProduct(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // For ADD mode, require image. For UPDATE mode, image is optional
    if (!_isUpdateMode && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final price = double.tryParse(_priceController.text) ?? 0.0;
    if (price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid price'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_isUpdateMode) {
      // UPDATE existing product
      final updatedProduct = Product(
        id: _existingProduct!.id, // Keep existing ID
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: price,
        imageUrl:
            _image?.path ??
            _existingProduct!.imageUrl, // Use new image or keep existing
      );

      print('🔄 Updating product: ${updatedProduct.name}');
      context.read<ProductBloc>().add(
        UpdateProductEvent(product: updatedProduct),
      );
    } else {
      // ADD new product
      final product = Product(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: price,
        imageUrl: _image!.path,
      );

      print('🆕 Adding product: ${product.name}');
      context.read<ProductBloc>().add(AddProductEvent(product: product));
    }
  }

  void _clearForm() {
    _nameController.clear();
    _categoryController.clear();
    _priceController.clear();
    _descriptionController.clear();
    setState(() {
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form cleared'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);

        if (await file.exists()) {
          setState(() {
            _image = file;
          });

          final fileSize = await file.length();
          final fileSizeMB = fileSize / (1024 * 1024);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${_isUpdateMode ? "New image" : "Image"} selected (${fileSizeMB.toStringAsFixed(1)}MB)', // ✅ CHANGE THIS LINE
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          throw Exception('Selected file does not exist');
        }
      }
    } catch (e) {
      print('❌ Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
