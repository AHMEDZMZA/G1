import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_screens/presentation/view/top_seller/manager/best)seller_state.dart';
import '../../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';



class TopSellersList extends StatelessWidget {
  const TopSellersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BestSellerFailure) {
          return Text(state.errorMessage);
        }

        if (state is BestSellerSuccess) {
          if (state.sellers.isEmpty) {
            return const Center(
              child: Text(
                'No Sellers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.sellers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = state.sellers[index];

                return Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          product.imageUrl ?? '',
                          errorBuilder: (_, __, ___) {
                            return Image.asset(
                              'assets/images/bestseller.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
