import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product/data/product_details_repo.dart';
import 'package:graduation2/feauture/product/manager/product_details_cubit.dart';
import 'package:graduation2/feauture/product/view/product_datails.dart';
import 'package:graduation2/feauture/product_screens/manager/product_cubit.dart';
import 'package:graduation2/feauture/product_screens/manager/product_state.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/number_product_state.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.user});
  final user;
  @override
  Widget build(BuildContext context) {
    int count = 0;
    return BlocBuilder<ProductCountCubit, ProductCountState>(
      builder: (context, countState) {
        if (countState is ProductCountLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (countState is ProductCountSuccess && countState.count == 0) {
          return const Center(
            child: Text('No products found!', style: TextStyle(fontSize: 16)),
          );
        }
        if (countState is ProductCountError) {
          return Center(child: Text(countState.message));
        }
        if (countState is ProductCountSuccess) {
          count = countState.count;
        }
        return BlocBuilder<ProductsCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductFailure) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is ProductSuccess) {
              final product = state.products;
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemCount: count,
                itemBuilder: (context, index) {
                  print('🔥 Product ID Sent = ${product[index].id}');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                ProductDetailsCubit(ProductDetailsRepo()),
                            child: ProductDetails(productId: product[index].id),
                          ),
                        ),
                      );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => BlocProvider(
                      //       create: (_) => ProductDetailsCubit(ProductDetailsRepo())
                      //         ..fetchProductDetails(product[index].id),
                      //       child:  ProductDetails(productId: product[index].id,),
                      //     ),
                      //   ),
                      // );
                    },

                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) {
                    //         return ProductDetails(product: product[index]);
                    //       },
                    //     ),
                    //   );
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.network(
                                state.products[index].imageUrl ??
                                    'assets/images/no_photo.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: Image.network(
                          //       state.products[index].imageUrl ??
                          //           'assets/images/no_photo.png',
                          //       fit: BoxFit.cover,
                          //       width: double.infinity,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    state.products[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: Text(
                                    '${state.products[index].price.toString()}  EGP',
                                    style: const TextStyle(
                                      color: Color(0xff7A4A32),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return SizedBox();
          },
        );
      },
    );
  }
}
