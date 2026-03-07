import 'package:flutter/material.dart';
import 'package:graduation2/feauture/auth/views/widgets/custom_button.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/custom_button.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/posts_profile.dart';
import 'package:graduation2/feauture/profile/views/myprofile/widgets/reviews_customer.dart';


class CustomerProfile extends StatelessWidget {
  const CustomerProfile({super.key, required this.user, this.onGoHome});
  final user;

  final VoidCallback? onGoHome;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: width * .08,
                backgroundImage: user.profileImage != null
                    ? NetworkImage(
                        user.profileImage ?? 'assets/images/person.png',
                      )
                    : AssetImage('assets/images/person.png'),
                // backgroundImage: AssetImage('assets/images/topseller.png'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      '${user.firstName} ${user.secondName}',
                      style: TextStyle(
                        color: const Color(0xFF3E2723),
                        fontSize: 16,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      user.specialization ??
                          'Handmade enthusiast | Love supporting local',
                      style: TextStyle(
                        color: const Color(0xFF8D6E63),
                        fontSize: 12,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.63,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: const Color(0xFF8D6E63),
                          size: 14,
                        ),
                        Text(
                          '12 Posts  .',
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 12,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                        Icon(
                          Icons.star_outline_outlined,
                          color: const Color(0xFF8D6E63),
                          size: 14,
                        ),
                        Text(
                          '12 Reviews ',
                          style: TextStyle(
                            color: const Color(0xFF8D6E63),
                            fontSize: 12,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonprofile(
                text: 'Orders',
                icon: Icons.shopping_bag_outlined,
                color1: const Color(0xFF6D4C41),
                color2: const Color(0xFF8D6E63),
              ),

              CustomButtonprofile(
                text: 'WishList',
                icon: Icons.favorite_outline,
                color1: const Color(0xFFC9A875),
                color2: const Color(0xFFD4AF37),
              ),
              CustomButtonprofile(
                text: 'Messages',
                icon: Icons.message_outlined,
                color1: const Color(0xFFC9A875),
                color2: const Color(0xFFD4AF37),
                message: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                      Tab(text: 'Posts'),

                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Content
                SizedBox(
                  height: height * .55,
                  width: double.infinity,

                  // مهم ❗ عشان TabBarView
                  child: TabBarView(
                    children: [
                      //  PostsView(),
                      PostsView(),
                      ReviewCustomer(),
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
