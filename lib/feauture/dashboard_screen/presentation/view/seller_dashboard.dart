// /// Seller Dashboard Screen
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../product_screens/data/model/create_product_model.dart';
// import '../../../product_screens/manager/product_cubit.dart';
// import '../../../product_screens/presentation/view/Editprodect_screen/editprodect.dart';
// import '../../../product_screens/presentation/view/addprodect_screen/creatprodect.dart';
// import '../../data/repo/repo_dashboard_Imple.dart';
// import '../../manager/sellerdashboard_apiserves.dart';
// import '../../manager/sellerdashboard_cubit.dart';
// import '../../manager/sellerdashboard_state.dart';
//
// class SellerDashboardScreen extends StatefulWidget {
//   const SellerDashboardScreen({super.key});
//
//   @override
//   State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
// }
//
// class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return
//       BlocProvider(
//           create: (context) => ProductsellerCubit(
//             RepoDashboardImple(ProductsellerdashboardApiService()),
//           )..getProducts(),
//           child:Scaffold(
//         backgroundColor: const Color(0xFFF9F6F1),
//         body: Column(
//           children: [
//             _buildHeader(context),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     _buildConsultationsSection(),
//                     const SizedBox(height: 24),
//                     _buildProductsHeader(context),
//                     const SizedBox(height: 12),
//                     BlocBuilder<ProductsellerCubit,
//                         ProductsellerdashboardState>(
//                       builder: (context, state) {
//                         if (state is ProductsellerdLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//
//                         if (state is ProductsellerdSuccess) {
//                           if (state.products.isEmpty) {
//                             return const Center(
//                               child: Text(
//                                 "No Products Yet",
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             );
//                           }
//
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: state.products.length,
//                             itemBuilder: (context, index) {
//                               final p = state.products[index];
//                               final product = CreateProductResponseModel(
//                                 id: p.id,
//                                 name: p.name,
//                                 price: p.price,
//                                 quantity: p.stock,
//                                 description: p.description,
//                                 imageUrl: p.image,
//                                 categoryId: p.categoryId,
//                                 categoryName: p.categoryName ?? '',
//                                 sellerId: '',
//                               );
//
//                               return _buildProductItem(
//                                 context: context,
//                                 product: product,
//                                 onDelete: () async {
//                                   await context
//                                       .read<DeleteProductCubit>()
//                                       .deleteProduct(product.id);
//
//                                   if (context.mounted) {
//                                     context.read<ProductsellerCubit>().removeProduct(product.id);
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: const Row(
//                                           children: [
//                                             Icon(Icons.check_circle, color: Colors.white),
//                                             SizedBox(width: 10),
//                                             Text(
//                                               'Product deleted successfully',
//                                               style: TextStyle(color: Colors.white),
//                                             ),
//                                           ],
//                                         ),
//                                         backgroundColor: const Color(0xFF6B4F46),
//                                         behavior: SnackBarBehavior.floating,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(12),
//                                         ),
//                                         margin: const EdgeInsets.all(16),
//                                         duration: const Duration(seconds: 3),
//                                       ),
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           );
//                         }
//
//                         if (state is ProductsellerdError) {
//                           return Center(
//                             child: Text(
//                               state.message,
//                               style: const TextStyle(color: Colors.red),
//                             ),
//                           );
//                         }
//
//                         return const SizedBox();
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     _buildRawMaterialsBanner(),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ));
//   }
//
//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//           colors: [Color(0xFF6B4F46), Color(0xFFC6A684)],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const CircleAvatar(
//                   backgroundColor: Colors.white24,
//                   child: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Seller Dashboard',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: const [
//                       Icon(Icons.stars, color: Colors.amber, size: 16),
//                       SizedBox(width: 4),
//                       Text(
//                         'Expert Seller',
//                         style: TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Row(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(right: 8),
//                     decoration: const BoxDecoration(
//                       color: Colors.white24,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.add, color: Colors.white),
//                       onPressed: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const AddProductScreen()),
//                         );
//                         if (result == true && context.mounted) {
//                           context.read<ProductsellerCubit>().getProducts();
//                         }
//                       },
//                     ),
//                   ),
//                   const CircleAvatar(
//                     backgroundColor: Colors.white24,
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 25),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildStatCard('Products', '24', Icons.inventory_2_outlined),
//               _buildStatCard('Sales', '156', Icons.trending_up),
//               _buildStatCard('Revenue', 'EGP 42k', Icons.attach_money),
//               _buildStatCard('Sessions', '12', Icons.calendar_today,
//                   isSelected: true),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatCard(String label, String value, IconData icon,
//       {bool isSelected = false}) {
//     return Container(
//       width: 75,
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         color: isSelected
//             ? Colors.white.withOpacity(0.2)
//             : Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         border: isSelected
//             ? Border.all(color: Colors.amber.withOpacity(0.5))
//             : null,
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: Colors.white70, size: 20),
//           const SizedBox(height: 8),
//           Text(label,
//               style: const TextStyle(color: Colors.white60, fontSize: 10)),
//           Text(value,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildConsultationsSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFDF8F1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.brown.withOpacity(0.1)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_month, color: Colors.amber),
//                   const SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('My Consultations',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text('2 new requests',
//                           style:
//                           TextStyle(color: Colors.grey, fontSize: 12)),
//                     ],
//                   ),
//                 ],
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text('View All',
//                     style: TextStyle(color: Colors.brown)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Row(
//               children: [
//                 const CircleAvatar(
//                   backgroundColor: Color(0xFFF3EEE7),
//                   child: Icon(Icons.person, color: Colors.brown),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('Sarah Martinez',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text('Pottery Basics',
//                           style:
//                           TextStyle(color: Colors.grey, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.amber.shade100,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Text('New',
//                       style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductsHeader(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'My Products',
//           style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.brown),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             final result = await Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const AddProductScreen()),
//             );
//             if (result == true && context.mounted) {
//               context.read<ProductsellerCubit>().getProducts();
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.brown,
//             elevation: 0,
//             side: const BorderSide(color: Colors.brown),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20)),
//           ),
//           child: const Text('Add New'),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductItem({
//     required BuildContext context,
//     required CreateProductResponseModel product,
//     required VoidCallback onDelete,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.02), blurRadius: 10),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: Image.network(
//               product.imageUrl,
//               width: 70,
//               height: 70,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) =>
//                   Container(
//                     width: 70,
//                     height: 70,
//                     color: Colors.grey.shade200,
//                     child: const Icon(Icons.image, color: Colors.grey),
//                   ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 Text(
//                   'EGP ${product.price}',
//                   style: const TextStyle(
//                       color: Colors.brown, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Stock: ${product.quantity}',
//                   style:
//                   const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           OutlinedButton(
//             onPressed: () async {
//               final result = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => EditProductScreen(product: product),
//                 ),
//               );
//               if (result == true && context.mounted) {
//                 context.read<ProductsellerCubit>().getProducts();
//               }
//             },
//             style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               side: const BorderSide(color: Colors.brown),
//             ),
//             child: const Text('Edit',
//                 style: TextStyle(color: Colors.brown, fontSize: 12)),
//           ),
//           const SizedBox(width: 8),
//           GestureDetector(
//             onTap: onDelete,
//             child: const Icon(
//               Icons.delete_outline,
//               color: Colors.brown,
//               size: 24,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRawMaterialsBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3EEE7),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Need Raw Materials?',
//               style:
//               TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           const Text('Browse supplies from verified suppliers',
//               style: TextStyle(color: Colors.grey, fontSize: 13)),
//           const SizedBox(height: 15),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF8D6E63),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15)),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//               child: const Text('Browse Materials',
//                   style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product_screens/data/model/create_product_model.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/presentation/view/Editprodect_screen/editprodect.dart';
import '../../../product_screens/presentation/view/addprodect_screen/creatprodect.dart';
import '../../data/repo/repo_dashboard_Imple.dart';
import '../../manager/sellerdashboard_apiserves.dart';
import '../../manager/sellerdashboard_cubit.dart';
import '../../manager/sellerdashboard_state.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  late ProductsellerCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ProductsellerCubit(
      RepoDashboardImple(ProductsellerdashboardApiService()),
    )..getProducts();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F6F1),
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildConsultationsSection(),
                    const SizedBox(height: 24),
                    _buildProductsHeader(context),
                    const SizedBox(height: 12),
                    BlocBuilder<ProductsellerCubit, ProductsellerdashboardState>(
                      builder: (context, state) {
                        if (state is ProductsellerdLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state is ProductsellerdSuccess) {
                          if (state.products.isEmpty) {
                            return const Center(
                              child: Text("No Products Yet",
                                  style: TextStyle(color: Colors.grey)),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final p = state.products[index];
                              final product = CreateProductResponseModel(
                                id: p.id,
                                name: p.name,
                                price: p.price,
                                quantity: p.stock,
                                description: p.description,
                                imageUrl: p.image,
                                categoryId: p.categoryId,
                                categoryName: p.categoryName ?? '',
                                sellerId: '',
                              );

                              return _buildProductItem(
                                context: context,
                                product: product,
                                onDelete: () async {
                                  await context
                                      .read<DeleteProductCubit>()
                                      .deleteProduct(product.id);

                                  if (mounted) {
                                    _cubit.removeProduct(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.white),
                                            SizedBox(width: 10),
                                            Text('Product deleted successfully',
                                                style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFF6B4F46),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        margin: const EdgeInsets.all(16),
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        }

                        if (state is ProductsellerdError) {
                          return Center(
                            child: Text(state.message,
                                style: const TextStyle(color: Colors.red)),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildRawMaterialsBanner(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6B4F46), Color(0xFFC6A684)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seller Dashboard',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: const [
                      Icon(Icons.stars, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('Expert Seller',
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                        color: Colors.white24, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddProductScreen()),
                        );
                        if (result == true && mounted) {
                          _cubit.getProducts();
                        }
                      },
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Products', '24', Icons.inventory_2_outlined),
              _buildStatCard('Sales', '156', Icons.trending_up),
              _buildStatCard('Revenue', 'EGP 42k', Icons.attach_money),
              _buildStatCard('Sessions', '12', Icons.calendar_today, isSelected: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon,
      {bool isSelected = false}) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(0.2)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: isSelected ? Border.all(color: Colors.amber.withOpacity(0.5)) : null,
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildConsultationsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF8F1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.amber),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('My Consultations',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('2 new requests',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All',
                    style: TextStyle(color: Colors.brown)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFF3EEE7),
                  child: Icon(Icons.person, color: Colors.brown),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Sarah Martinez',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Pottery Basics',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('New',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('My Products',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()),
            );
            if (result == true && mounted) {
              _cubit.getProducts();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.brown,
            elevation: 0,
            side: const BorderSide(color: Colors.brown),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('Add New'),
        ),
      ],
    );
  }

  Widget _buildProductItem({
    required BuildContext context,
    required CreateProductResponseModel product,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              product.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text('EGP ${product.price}',
                    style: const TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold)),
                Text('Stock: ${product.quantity}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => EditProductScreen(product: product)),
              );
              if (result == true && mounted) {
                _cubit.getProducts();
              }
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              side: const BorderSide(color: Colors.brown),
            ),
            child: const Text('Edit',
                style: TextStyle(color: Colors.brown, fontSize: 12)),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete_outline, color: Colors.brown, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildRawMaterialsBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EEE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Need Raw Materials?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Browse supplies from verified suppliers',
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8D6E63),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Browse Materials',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}