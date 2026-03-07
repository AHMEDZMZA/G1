import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product/data/product_details_repo.dart';
import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/widget/prodect_card_widget.dart';
import 'package:graduation2/feauture/product_screens/presentation/view/explore_prodect/widget/search_filter_bar.dart';

import '../../../../../core/services/api_services.dart';
import '../../../../product/view/product_datails.dart';
import '../../../manager/prodect_apiservice.dart';
import '../../../manager/product_cubit.dart';
import '../../../manager/product_state.dart';

class ExploreAllScreen extends StatelessWidget {
  const ExploreAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(ProductApiService())..fetchAllProducts(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F6F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.brown,
            size: 20,
          ),
          title: const Text(
            'All Products',
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.brown,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            SearchFilterBar(onFilterTap: () {}),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.brown),
                    );
                  } else if (state is ProductSuccess) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
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
                        return ProductCardWidget(
                          title: product.name,
                          price: product.price.toString(),
                          rating: product.rating.toString(),
                          imageUrl: product.imageUrl,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) =>
                                      ProductDetailsCubit(ProductDetailsRepo()),
                                  child: ProductDetails(productId: product.id),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is ProductFailure) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
