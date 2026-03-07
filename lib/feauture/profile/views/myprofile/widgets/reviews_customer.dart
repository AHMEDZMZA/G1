import 'package:flutter/material.dart';

class ReviewCustomer extends StatelessWidget {
  const ReviewCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .65,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},

          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEFEBE9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/topseller.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: const Color(0xffC9A875),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: const Color(0xffC9A875),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: const Color(0xffC9A875),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          'Handmade Review',
                          style: const TextStyle(color: Color(0xff7A4A32)),
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
}
