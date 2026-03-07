import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_cubit.dart';
import 'package:graduation2/feauture/profile/manager/profile_state.dart';
import 'package:graduation2/feauture/profile/views/myprofile/customer_profile.dart';

import 'package:graduation2/feauture/profile/views/myprofile/seller_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/supplier_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, this.onGoHome});
  final VoidCallback? onGoHome;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xffEFEBE9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: onGoHome?.call,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xff6D4C41),
          ),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 16,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: Icon(Icons.settings_outlined, color: Color(0xff6D4C41)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
     
      body: SafeArea(
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserProfileFailure) {
              return Center(child: Text(state.message));
            }

            if (state is UserProfileSuccess) {
              final user = state.profile;
              // if (user.roleType == 'Expert') {
              //   return BlocProvider(
              //     create: (_) =>
              //         ProductCountCubit(ProductApiService())
              //           ..fetchMyProductsCount(),
              //     child: ExpertProfile(user: user, onGoHome: onGoHome),
              //   );
              // }
              if (user.roleType == 'Beginner') {
                return BlocProvider(
                  create: (_) =>
                      ProductCountCubit(ProductApiService())
                        ..fetchMyProductsCount(),
                  child: SellerProfile(user: user, onGoHome: onGoHome),
                );
              } else if (user.roleType == 'Expert') {
                return BlocProvider(
                  create: (_) =>
                      ProductCountCubit(ProductApiService())
                        ..fetchMyProductsCount(),
                  child: CustomerProfile(user: user, onGoHome: onGoHome),
                );
              }
              else if (user.roleType == 'Supplier') {
                return BlocProvider(
                  create: (_) =>
                      ProductCountCubit(ProductApiService())
                        ..fetchMyProductsCount(),
                  child: Supplierprofile(user: user, onGoHome: onGoHome),
                );
              }
            }
            return const Center(child: SizedBox());
          },
        ),
      ),
    );
  }
}
