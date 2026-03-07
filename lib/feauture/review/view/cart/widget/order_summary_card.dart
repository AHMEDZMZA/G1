import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;
  final double shipping;

  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .2,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w700,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 8),
          _row("Subtotal", subtotal),
          const SizedBox(height: 8),
          _row("Shipping", shipping),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 16,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFFC9A875),
                  fontSize: 18.50,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String title, double value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF8D6E63),
            fontSize: 13.25,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xffB88E2F) : Color(0xFF3E2723),
          ),
        ),
      ],
    );
  }
}
