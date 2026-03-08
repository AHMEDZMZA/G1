import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/Editprodect_screen/widget/custom_prodectimagebox.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/Editprodect_screen/widget/custom_prodectlabel.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/Editprodect_screen/widget/customprodect_textfield.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../../home/manager/category_cubit.dart';
import '../../../../home/manager/category_state.dart';
import '../../../../home/data/model/categories_model_forhome.dart';
import '../../../data/model/create_product_model.dart';
import '../../../data/model/update_product.dart';
import '../../../manager/product_cubit.dart';
import '../../../manager/product_state.dart';

class EditProductScreen extends StatefulWidget {
  final CreateProductResponseModel product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController nameEnController;
  late TextEditingController nameArController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController descriptionController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    nameEnController = TextEditingController(text: widget.product.name);
    nameArController = TextEditingController();
    priceController = TextEditingController(text: widget.product.price.toString());
    stockController = TextEditingController(text: widget.product.quantity.toString());
    descriptionController = TextEditingController(text: widget.product.description);

    selectedCategoryId = widget.product.categoryId != 0
        ? widget.product.categoryId
        : null;
  }

  Future<void> _pickNewImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    nameEnController.dispose();
    nameArController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
      body: BlocConsumer<UpdateProductCubit, UpdateProductState>(
        // listener: (context, state) {
        //   if (state is UpdateSuccessState) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Product updated successfully! ✅')),
        //     );
        //     Navigator.pop(context);
        //   } else if (state is UpdateErrorState) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text('Error: ${state.message}')),
        //     );
        //   }
        // },
        listener: (context, state) {
          if (state is UpdateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product updated successfully! ✅')),
            );
            Navigator.pop(context, true);
          } else if (state is UpdateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductLabel('Product Image'),
                const SizedBox(height: 8),
                ProductImageBox(
                  imagePath: _selectedImage?.path ?? widget.product.imageUrl,
                  onTap: _pickNewImage,
                  onDelete: _deleteImage,
                ),
                const SizedBox(height: 16),
                const ProductLabel('Product Name (English)'),
                ProductTextField(controller: nameEnController),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ProductLabel('Price (EGP)'),
                          ProductTextField(controller: priceController),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ProductLabel('Stock'),
                          ProductTextField(controller: stockController),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const ProductLabel('Category'),
                const SizedBox(height: 6),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, categoryState) {
                    if (categoryState is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final categories = categoryState is CategorySuccess
                        ? categoryState.categories
                        : <CategoriesModel>[];

                    return DropdownButtonFormField<int>(
                      value: selectedCategoryId,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      hint: Text(widget.product.categoryName ?? 'Select Category'),
                      items: categories.map((category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryId = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                const ProductLabel('Description'),
                ProductTextField(
                  controller: descriptionController,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.brown.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: state is UpdateLoadingState
                            ? null
                            : () {
                          context.read<UpdateProductCubit>().updateProduct(
                            UpdateProductRequestModel(
                              id: widget.product.id,
                              nameEn: nameEnController.text,
                              nameAr: nameArController.text,
                              price: int.tryParse(priceController.text) ?? 0,
                              quantity: int.tryParse(stockController.text) ?? 0,
                              description: descriptionController.text,
                              categoryId: selectedCategoryId ?? 0,
                              imageFile: _selectedImage?.path,
                              tags: const [],
                              sellerName: widget.product.sellerName ?? '',
                            ),
                          );
                        },
                        child: state is UpdateLoadingState
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Update Product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

