import 'dart:io';
import 'package:flutter/material.dart';

class ProductImageBox extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ProductImageBox({
    super.key,
    this.imagePath,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EEE7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.brown.shade200),
            ),
            child: imagePath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImage(imagePath!), // دالة ذكية لعرض الصورة حسب نوعها
            )
                : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_outlined, size: 30, color: Colors.brown),
                SizedBox(height: 6),
                Text('Upload Photo', style: TextStyle(color: Colors.brown)),
              ],
            ),
          ),
          if (imagePath != null && onDelete != null)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // دالة لتحديد طريقة عرض الصورة
  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      // إذا كانت الصورة رابط إنترنت (قادمة من السيرفر)
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        // عرض مؤشر تحميل لحين ظهور الصورة
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(color: Colors.brown));
        },
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
      );
    } else {
      // إذا كانت الصورة ملف محلي (تم اختيارها من المعرض)
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }
}