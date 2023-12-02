import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Container(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.onPrimary,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'List of Showtime movies',
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: colors.onPrimary,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
