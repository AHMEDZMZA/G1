import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../manager/prodect_apiservice.dart';
import '../../../../manager/product_cubit.dart';
import '../../../../manager/product_state.dart';
import 'widget/top_prodect_card.dart';

class TopProductsScreen extends StatelessWidget {
  const TopProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductCubit(ProductApiService())..fetchTopProducts(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFBFA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.brown,
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          title: Column(
            children: [
              const Text(
                'Best Sellers',
                style: TextStyle(
                  color: Color(0xFF4E342E),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Top-selling handmade products',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        // 👇 هنا الربط بالـ Bloc
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            }

            if (state is ProductFailure) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is ProductSuccess) {
              return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return TopProductCard(
                    rank: index + 1,
                    name: product.name,
                    price: product.price.toString(),
                    rating: product.rating.toString(),
                    imageUrl: product.imageUrl,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
