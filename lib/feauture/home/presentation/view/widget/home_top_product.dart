import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/manager/product_cubit.dart';
import '../../../../product_screens/manager/product_state.dart';
import '../../../../product_screens/presentation/view/top_prodect/view/widget/top_prodect_card.dart';


class HomeTopProductsSection extends StatelessWidget {
  const HomeTopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.brown),
            ),
          );
        }

        if (state is ProductFailure) {
          return const SizedBox();
        }

        if (state is ProductSuccess) {
          final products = state.products.take(4).toList();

          return SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return SizedBox(
                  width: 170,
                  child: TopProductCard(
                    rank: index + 1,
                    name: product.name,
                    price: product.price.toString(),
                    rating: product.rating.toString(),
                    imageUrl: product.imageUrl,
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
