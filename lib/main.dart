import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/auth/manager/auth_cubit.dart';
import 'package:graduation2/feauture/auth/views/check_email.dart';
import 'package:graduation2/feauture/auth/views/login_screen.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/views/myprofile/profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
import 'package:graduation2/feauture/product/view/product_datails.dart';
import 'package:graduation2/feauture/review/view/cart/cart_screen.dart';
import 'package:graduation2/feauture/review/view/write_review.dart';
import 'package:graduation2/feauture/splash_screen/presentation/view/splash.dart';

import 'core/utils/pref_helpers.dart';
import 'feauture/home/manager/category_cubit.dart';
import 'feauture/language/lnguage_view.dart';
import 'feauture/product_screens/data/repo/repo_product.dart';
import 'feauture/product_screens/data/repo/repo_product_imple.dart';
import 'feauture/product_screens/manager/prodect_apiservice.dart';
import 'feauture/product_screens/manager/product_cubit.dart';
import 'feauture/product_screens/presentation/view/addprodect_screen/creatprodect.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedLang = await PrefHelpers.getLanguage() ?? 'en';

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLang),
      child: const CratoriaApp(),
    ),
  );
}

class CratoriaApp extends StatelessWidget {
  const CratoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteProductCubit(
            repoProduct: RepoProductImple(
              productApiService: ProductApiService(),
            ),
          ),
        ),
        BlocProvider(create: (_) => AuthCubit(ApiService())),
        BlocProvider(
          create:
              (context) => UserProfileCubit(UserProfileRepo())..fetchProfile(),
        ),
        BlocProvider(
          create:
              (context) => CreateProductCubit(
                repoProduct: RepoProductImple(
                  productApiService: ProductApiService(),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  CategoryCubit(ProductApiService())..fetchCategories(),
        ),
        BlocProvider(
          create:
              (context) => UpdateProductCubit(
                repoProduct: RepoProductImple(
                  productApiService: ProductApiService(),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEFEBE9),
          textTheme: GoogleFonts.arimoTextTheme(),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF3E2723),
            secondary: Color(0xFF8D6E63),
          ),
        ),
        home: LanguageView(),
      ),
    );
  }
}
