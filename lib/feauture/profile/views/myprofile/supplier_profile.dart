import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/manager/number_product_cubit.dart';
import 'package:graduation2/feauture/profile/manager/number_product_state.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/numberandtype.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/products.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews.dart';
import 'package:graduation2/feauture/product_screens/manager/product_cubit.dart';

import 'package:graduation2/feauture/review/data/review_service.dart';
import 'package:graduation2/feauture/review/view/widgets/custom_star.dart';

class Supplierprofile extends StatefulWidget {
  const Supplierprofile({super.key, required this.user, this.onGoHome});
  final user;

  final VoidCallback? onGoHome;
  @override
  State<Supplierprofile> createState() => _SupplierprofileState();
}

class _SupplierprofileState extends State<Supplierprofile> {
  bool isLoading = true;
  final ReviewApiService _reviewApiService = ReviewApiService();
  @override
  void initState() {
    super.initState();
    userstate();
  }

  double averageRating = 0.0;
  int totalReviews = 0;
  bool isLoadingRating = true;

  Future<void> userstate() async {
    final stats = await _reviewApiService.getUserState(widget.user.id);

    if (stats != null) {
      setState(() {
        averageRating = stats.averageRating;
        totalReviews = stats.totalReviews;
        isLoadingRating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int count = 0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: width * .11,
                    backgroundColor: const Color.fromARGB(255, 222, 221, 221),
                    child: CircleAvatar(
                      radius: width * .1,
                      backgroundImage: widget.user.profileImage != null
                          ? NetworkImage(
                              widget.user.profileImage ??
                                  'assets/images/person.png',
                            )
                          : AssetImage('assets/images/person.png'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [Color(0xffFFD700), Color(0xffC9A875)],
                      ),
                    ),
                    child: Icon(Icons.star, color: Colors.white, size: 20),
                  ),
                ],
              ),

              BlocBuilder<ProductCountCubit, ProductCountState>(
                builder: (context, state) {
                  if (state is ProductCountLoading) {
                    return const CircularProgressIndicator(strokeWidth: 2);
                  }

                  if (state is ProductCountSuccess) {
                    count = state.count;
                    return NumberOfType(number: state.count, type: 'Matrials');
                  }
                  return NumberOfType(number: 0, type: 'Matrials');
                },
              ),

              NumberOfType(number: 45, type: 'Orders'),
              NumberOfType(number: 45, type: 'Reviews'),
            ],
          ),
          SizedBox(height: height * .01),
          Row(
            children: [
              Text(
                '${widget.user.firstName} ${widget.user.secondName}',
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 14.25,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
              SizedBox(width: width * .03),
              Container(
                width: width * .12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    colors: [Color(0xff8D6E63), Color(0xffA1887F)],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Seller',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      height: 1.43,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * .01),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Master Ceramicist',
              style: TextStyle(
                color: const Color(0xFF6D4C41),
                fontSize: 10.50,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
          SizedBox(height: height * .01),
          Row(
            children: [
              RatingStars(rating: averageRating),
              // for (int i = 0; i < 4; i++)
              //   Icon(Icons.star, color: Color(0xffC9A875), size: 15),
              // Icon(Icons.star_border_outlined, size: 15),
              isLoadingRating
                  ? const SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      ' ${averageRating.toStringAsFixed(1)}   (${totalReviews}) ',

                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 11,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
              // Text(
              //   '4.9 (248 reviews)',
              //   style: TextStyle(
              //     color: const Color(0xFF8D6E63),
              //     fontSize: 11,
              //     fontFamily: 'Arimo',
              //     fontWeight: FontWeight.w400,
              //     height: 1.50,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: height * .01),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '12+ years creating wheel-thrown pottery ',
              style: TextStyle(
                color: const Color(0xFF8D6E63),
                fontSize: 11,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: height * .025),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [Color(0xff6D4C41), Color(0xff8D6E63)],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Row(
                        children: [
                          Icon(Icons.card_travel_rounded, color: Colors.white),
                          const SizedBox(width: 7),
                          Text(
                            'Orders',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * .01),
              Container(
                width: width * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xff6D4C41), width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Color(0xff6D4C41),
                          fontSize: 14,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * .01),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // Tabs
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: const TabBar(
                    indicatorColor: Color(0xff7A4A32),
                    indicatorWeight: 2,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Products'),

                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Content
                SizedBox(
                  height: 400, // مهم ❗ عشان TabBarView
                  child: TabBarView(
                    children: [
                      BlocProvider(
                        create: (context) =>
                            ProductsCubit(ProductOwnerProfileRepo())
                              ..getProducts(widget.user.id),
                        child: ProductsGrid(user: widget.user),
                      ),
                      ReviewsView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
