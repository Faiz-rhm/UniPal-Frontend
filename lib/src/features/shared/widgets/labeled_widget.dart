import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

class LabeledWidget extends StatelessWidget {
  final Widget child;
  final String label;
  final SizedBox labelGap;
  final SizedBox horizontalLabelGap;
  final TextStyle labelStyle;
  final bool useDarkerLabel;
  final Axis labelDirection;
  final bool expand;

  const LabeledWidget({
    Key? key,
    required this.child,
    required this.label,
    this.labelGap = Insets.gapH5,
    this.expand = false,
    this.horizontalLabelGap = Insets.gapW10,
    this.labelDirection = Axis.vertical,
    this.useDarkerLabel = false,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      color: AppColors.textLightGreyColor,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      // Label
      Text(
        label,
        style: useDarkerLabel ? AppTypography.primary.body16 : labelStyle,
      ),

      if (labelDirection == Axis.vertical) labelGap else horizontalLabelGap,

      // Widget
      if (expand) Expanded(child: child) else child,
    ];
    return labelDirection == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
        : Row(children: children);
  }
}
