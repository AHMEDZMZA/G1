import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/addprodect_screen/widget/input_field.dart';
import 'dart:io';
import '../../../../home/data/model/categories_model_forhome.dart';
import '../../../../home/manager/category_cubit.dart';
import '../../../../home/manager/category_state.dart';
import '../../../data/model/create_product_model.dart';
import '../../../manager/product_cubit.dart';
import '../../../manager/product_state.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final nameArController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int? selectedCategoryId;

  List<String> tags = [
    "handmade",
    "vintage",
    "unique",
    "eco-friendly",
    "custom",
    "gift",
  ];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    nameArController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: BlocConsumer<CreateProductCubit, CreateProductState>(
            listener: (context, state) {
              if (state is CreateSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added successfully!')),
                );
                Navigator.pop(context, true);
              } else if (state is CreateErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to add product!')),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildLabel('Product Image'),
                  const SizedBox(height: 8),
                  _buildImagePicker(),
                  const SizedBox(height: 16),
                  _buildLabel('Product Name (English)'),
                  CustomTextField(
                    hint: 'e.g. Handmade Ceramic Bowl',
                    controller: nameController,
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('اسم المنتج (عربي)'),
                  CustomTextField(
                    hint: 'مثال: وعاء خزفي يدوي',
                    controller: nameArController,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildNumericField(
                          'Price (EGP)',
                          '0.00',
                          priceController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildNumericField(
                          'Stock',
                          '0',
                          stockController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildLabel('Category'),
                  const SizedBox(height: 6),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, categoryState) {
                      print(' CategoryState: $categoryState');
                      if (categoryState is CategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (categoryState is CategoryFailure) {
                        return Text('Error: ${categoryState.error}');
                      }

                      final categories =
                          categoryState is CategorySuccess
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
                        hint: const Text("Select Category"),
                        items:
                            categories.map((category) {
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
                  const SizedBox(height: 12),
                  _buildLabel('Description'),
                  CustomTextField(
                    hint: 'Describe your product...',
                    maxLines: 4,
                    controller: descriptionController,
                  ),
                  const SizedBox(height: 12),
                  _buildLabel('Tags'),
                  const SizedBox(height: 8),
                  _buildLabel('Suggested:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children:
                        tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: const Color(0xffB58E6A),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                color: Color(0xff7A4A32),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: 'Add custom tag...',
                          controller: tagController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          if (tagController.text.isNotEmpty) {
                            setState(() {
                              tags.add(tagController.text.trim());
                              tagController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color(0xFFC4A06F),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildActionButtons(state),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.brown),
    );
  }

  Widget _buildNumericField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        CustomTextField(
          hint: hint,
          controller: controller,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Center(
        child: Container(
          height: 98,
          width: 98,
          decoration: BoxDecoration(
            color: const Color(0xFFF3EEE7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child:
              _selectedImage == null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.upload_outlined,
                        size: 30,
                        color: Colors.brown,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Upload Photo',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ],
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(CreateProductState state) {
    return Row(
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
            child: const Text('Cancel', style: TextStyle(color: Colors.brown)),
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
            onPressed:
                state is CreateLoadingState
                    ? null
                    : () {
                      context.read<CreateProductCubit>().addToCart(
                        CreateProductRequestModel(
                          nameEn: nameController.text,
                          nameAr: nameArController.text,
                          price: int.tryParse(priceController.text) ?? 0,
                          quantity: int.tryParse(stockController.text) ?? 0,
                          description: descriptionController.text,
                          categoryId: selectedCategoryId ?? 0,
                          imageFile: _selectedImage?.path ?? '',
                          tags: tags,
                        ),
                      );
                    },
            child:
                state is CreateLoadingState
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : const Text(
                      'Add Product',
                      style: TextStyle(color: Colors.white),
                    ),
          ),
        ),
      ],
    );
  }
}
