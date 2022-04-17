import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

class HomeAppBar extends ConsumerWidget {
  final List<Widget> tabs;
  const HomeAppBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      elevation: 0,
      toolbarHeight: 65,
      pinned: true,
      title: const Text('UniPal'),
      backgroundColor: AppColors.backgroundColor,
      leading: InkWell(
        onTap: () => ref.read(authProvider.notifier).logout(),
        child: const RotatedBox(
          quarterTurns: 2,
          child: Icon(Icons.logout_rounded, color: AppColors.redColor),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_rounded),
          onPressed: () => AppRouter.pushNamed(
            Routes.StudentProfileScreen,
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: AppColors.lightOutlineColor,
                width: 1.5,
              ),
            ),
          ),
          padding: const EdgeInsets.only(top: 2),
          child: TabBar(
            labelColor: AppColors.primaryColor,
            indicatorWeight: 3,
            indicatorColor: AppColors.primaryColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            unselectedLabelColor: AppColors.textLightGreyColor,
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
