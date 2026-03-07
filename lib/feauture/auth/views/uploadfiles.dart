import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation2/feauture/auth/views/success_screen.dart';

import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class ExpertVerificationScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String password;
  final String confirmPassword;
  final File? profileImage;

  const ExpertVerificationScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
    required this.gender,
  }) : super(key: key);

  @override
  State<ExpertVerificationScreen> createState() =>
      _ExpertVerificationScreenState();
}

class _ExpertVerificationScreenState extends State<ExpertVerificationScreen> {
  File? imageFile;
  File? pdfFile;
  String? selectedGender;
  final TextEditingController yearsController = TextEditingController();

  // ================= Pick File =================
  Future<void> pickFile(String type) async {
    FilePickerResult? result;

    if (type == 'image') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
    } else if (type == 'pdf') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    }

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.single.path;
      if (path == null) return;

      setState(() {
        if (type == 'image') {
          imageFile = File(path);
        } else {
          pdfFile = File(path);
        }
      });
    }
  }

  // ================= Remove File =================
  void removeFile(String type) {
    setState(() {
      if (type == 'image') {
        imageFile = null;
      } else {
        pdfFile = null;
      }
    });
  }

  int get filesNeeded {
    int count = 0;
    if (imageFile == null) count++;
    if (pdfFile == null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
      if (state is AuthSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ExpertSuccessScreen(),
          ),
        );
      }

      if (state is AuthFailureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }
    },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        body: SafeArea(
          child: Column(
            children: [
              // ================= Header =================
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Expert Verification',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              // ================= Steps =================
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepIndicator(1, true),
                    const SizedBox(width: 16),
                    _buildStepIndicator(2, false),
                  ],
                ),
              ),

              // ================= Content =================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              'Work Samples & Details',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Upload 2 work samples and complete your profile',
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),


                      GestureDetector(
                        onTap: _showFilePickerDialog,
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85, // 👈 ده المهم
                            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9F0),
                              border: Border.all(
                                color: const Color(0xFFD4A574),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.upload_file_outlined,
                                  size: 44,
                                  color: Colors.brown.shade700,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Tap to upload files',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.brown.shade700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$filesNeeded more needed',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.brown.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      if (imageFile != null)
                        _buildFileCard(
                            'Image', imageFile!.path.split('/').last, 'image'),
                      if (pdfFile != null)
                        _buildFileCard(
                            'PDF', pdfFile!.path.split('/').last, 'pdf'),

                      const SizedBox(height: 20),

                      const Text('Years of Experience *'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: yearsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'e.g. 5',
                        ),
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (imageFile == null ||
                                pdfFile == null
                                ) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text('Please complete all fields')),
                              );
                              return;
                            }

                            final years =
                            int.tryParse(yearsController.text);
                            if (years == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid years')),
                              );
                              return;
                            }

                            List<MultipartFile> profileImages = [];
                            List<MultipartFile> portfolioFiles = [];

                            if (widget.profileImage != null) {
                              profileImages.add(
                                await MultipartFile.fromFile(
                                    widget.profileImage!.path),
                              );
                            }

                            portfolioFiles.add(
                              await MultipartFile.fromFile(imageFile!.path),
                            );
                            portfolioFiles.add(
                              await MultipartFile.fromFile(pdfFile!.path),
                            );

                            context.read<AuthCubit>().registerWithFiles(
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              email: widget.email,
                              password: widget.password,
                              confirmPassword: widget.confirmPassword,
                              role: 'Expert',
                              gender: widget.gender,


                              yearsOfExperience: years,
                              profileImages: profileImages,
                              portfolioFiles: portfolioFiles,
                            );
                          },
                          child: const Text('Review & Continue'),
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

  Widget _buildStepIndicator(int step, bool isActive) {
    return CircleAvatar(
      radius: 20,
      backgroundColor:
      isActive ? const Color(0xFF6B4423) : Colors.grey.shade300,
      child: Text(
        '$step',
        style: TextStyle(
            color: isActive ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildFileCard(String type, String fileName, String fileType) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(
            fileType == 'image' ? Icons.image : Icons.picture_as_pdf,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(fileName, overflow: TextOverflow.ellipsis),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => removeFile(fileType),
          ),
        ],
      ),
    );
  }

  void _showFilePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imageFile == null)
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Upload Image'),
                onTap: () {
                  Navigator.pop(context);
                  pickFile('image');
                },
              ),
            if (pdfFile == null)
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Upload PDF'),
                onTap: () {
                  Navigator.pop(context);
                  pickFile('pdf');
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    yearsController.dispose();
    super.dispose();
  }
}
