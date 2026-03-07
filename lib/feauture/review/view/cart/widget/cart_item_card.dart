import 'package:flutter/material.dart';
import 'package:graduation2/feauture/review/data/cart_model.dart';
import 'package:http/http.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .14,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              item.image,
              width: 75,
              height: height * .085,
              fit: BoxFit.cover,
            ),
          ),

          // const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                item.title,
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 14,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                  height: 1.43,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: TextStyle(
                  color: const Color(0xFF8D6E63),
                  fontSize: 12.50,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "\$${item.price}",
                style: TextStyle(
                  color: const Color(0xFFC9A875),
                  fontSize: 14,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onDecrease,
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFFAF8F5),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Color(0xFF6D4C41),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   hoverColor: Color(0xFFFAF8F5),
                  //   icon: const Icon(
                  //     //color: Color(0xFFFAF8F5),
                  //     Icons.remove_circle_outline,
                  //   ),
                  //   onPressed: onDecrease,
                  // ),
                  Text("${item.quantity}"),
                  IconButton(
                    onPressed: onIncrease,
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF6D4C41),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Color(0xFFFAF8F5),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   //  color: Color(0xFF6D4C41),
                  //   highlightColor: Color(0xFF6D4C41),
                  //   icon: const Icon(Icons.add_circle_outline),
                  //   onPressed: onIncrease,
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
