import 'package:flutter/material.dart';

//Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart' as AppStyles;
import '../../../helpers/constants/app_typography.dart';

class Ratings extends StatelessWidget {
  final double rating;

  const Ratings({
    Key? key,
    required this.rating,
  }) : super(key: key);

  int numStars(double rating) {
    const currentRange = 10 - 1; //max - min of current range
    const targetRange = 5 - 0; //max - min of target range
    final currentRatio = (rating - 1) / currentRange;
    return (currentRatio * targetRange + 0).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final stars = numStars(rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Rating number
        Text(
          rating == 0 ? 'N/A' : rating.toString(),
          style: AppTypography.primary.body14.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        AppStyles.Insets.gapW10,

        //Rating stars
        for (int i = 0; i < stars; i++)
          Padding(
            padding: i == 0
                ? const EdgeInsets.only(right: 1)
                : const EdgeInsets.symmetric(horizontal: 1),
            child: const Icon(
              Icons.star,
              size: AppStyles.IconSizes.sm,
              color: AppColors.starsColor,
            ),
          ),

        //Empty stars
        for (int i = stars; i < 5; i++)
          Padding(
            padding: i == 0
                ? const EdgeInsets.only(right: 1)
                : const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.star,
              size: AppStyles.IconSizes.sm,
              color: Colors.grey[300],
            ),
          ),
      ],
    );
  }
}
