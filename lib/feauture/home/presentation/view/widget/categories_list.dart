import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manager/category_cubit.dart';
import '../../../manager/category_state.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is CategorySuccess) {
          return SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = state.categories[index];

                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                      (category.imageUrl == null ||
                          category.imageUrl.isEmpty)
                          ? const AssetImage(
                        'assets/images/material.png',
                      )
                          : NetworkImage(category.imageUrl)
                      as ImageProvider,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      category.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          );
        }
        else if (state is CategoryFailure) {
          return Text(state.error);
        }

        return const SizedBox();
      },
    );
  }
}
