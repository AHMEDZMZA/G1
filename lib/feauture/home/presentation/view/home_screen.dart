
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/categories_list.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/explore_button.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_app_bar.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/home_top_product.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/products_list.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/search_bar_widget.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/section_title.dart';
import 'package:graduation2/feauture/home/presentation/view/widget/top_sellers_list.dart';

import '../../../../core/rescources/colors.dart';
import '../../../product_screens/manager/prodect_apiservice.dart';
import '../../../product_screens/manager/product_cubit.dart';
import '../../../product_screens/presentation/view/explore_prodect/explore_screen.dart';
import '../../../product_screens/presentation/view/top_prodect/view/top_prodect_screen.dart';
import '../../../product_screens/presentation/view/top_seller/manager/best_seller_cubit.dart';
import '../../manager/category_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // تم حذف _currentIndex لأنه لم يعد له داعي هنا

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          CategoryCubit(ProductApiService())..fetchCategories(),
        ),
        BlocProvider(
          create: (context) =>
          ProductCubit(ProductApiService())..fetchTopProducts(),
        ),
        BlocProvider(
          create: (context) =>
          BestSellerCubit(ProductApiService())..fetchBestSellers(),
        )

      ],

      child: Scaffold(
        backgroundColor: AppColors.kBgColor,
        // تم حذف _bottomNav() من هنا تماماً ✅
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 16),
                const SearchBarWidget(),
                const SizedBox(height: 20),
                const SectionTitle(title: "Categories"),
                const SizedBox(height: 12),
                const CategoriesList(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: "Top Sellers",
                  trailing: "See All",
                  onTap: () {
      
                  },
                ),
                const SizedBox(height: 12),
                const TopSellersList(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: "Top prodect",
                  trailing: "View All",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TopProductsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const HomeTopProductsSection(),
                const SizedBox(height: 24),

              ],
            ),
          ),
        ),
      ),
    );
  }
}