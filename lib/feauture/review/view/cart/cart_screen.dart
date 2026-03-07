import 'package:flutter/material.dart';
import 'package:graduation2/feauture/product/view/widgets/custom_icon.dart';
import 'package:graduation2/feauture/review/data/cart_model.dart';
import 'package:graduation2/feauture/review/view/cart/widget/cart_item_card.dart';
import 'package:graduation2/feauture/review/view/cart/widget/order_summary_card.dart';
import 'package:graduation2/feauture/review/view/cart/widget/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> items = [
    CartItem(
      title: "Ceramic Bowl Set",
      subtitle: "Pottery Studio",
      image: "assets/images/bestseller.png",
      price: 45,
      quantity: 1,
    ),
    CartItem(
      title: "Handmade Necklace",
      subtitle: "Artisan Jewelry",
      image: "assets/images/bestseller.png",
      price: 32,
      quantity: 2,
    ),
  ];

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  final double shipping = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 18,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// المحتوى
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return CartItemCard(
                            item: items[index],
                            onIncrease: () {
                              setState(() {
                                items[index].quantity++;
                              });
                            },
                            onDecrease: () {
                              setState(() {
                                if (items[index].quantity > 0) {
                                  items[index].quantity--;
                                }
                              });
                            },
                            onDelete: () {
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      OrderSummaryCard(subtotal: subtotal, shipping: shipping),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              /// الزرار في آخر الصفحة
              PrimaryButton(text: "Proceed to Checkout", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
