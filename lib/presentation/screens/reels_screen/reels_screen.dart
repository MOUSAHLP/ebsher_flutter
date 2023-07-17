import 'package:absher/bloc/reels_bloc/reels_event.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/reels_screen/widgets/shimmer_reels.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/reels_bloc/reels_bloc.dart';
import '../../../bloc/reels_bloc/reels_state.dart';
import '../../../core/services/services_locator.dart';
import '../../../translations.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';
import 'widgets/body_reels.dart';
import '../../../core/app_router/app_router.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReelsBloc>(
      create: (BuildContext context) => ReelsBloc()..add(GetReels()),
      lazy: false,
      child: const ReelsScreenBody(),
    );
  }
}

class ReelsScreenBody extends StatefulWidget {
  const ReelsScreenBody({Key? key}) : super(key: key);

  @override
  State<ReelsScreenBody> createState() => _ReelsScreenBodyState();
}

class _ReelsScreenBodyState extends State<ReelsScreenBody>
    with TickerProviderStateMixin {
  late ReelsBloc storiesBloc;

  @override
  void initState() {
    storiesBloc = context.read<ReelsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    storiesBloc.playerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      direction: DismissiblePageDismissDirection.horizontal,
      onDismissed: () {
        AppRouter.pop(context);
      },
      key: const Key(''),
      child: SafeArea(
        child: Stack(
          children: [
            CustomAppBackGround(
              child: BlocConsumer<ReelsBloc, ReelsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ReelsLoading) {
                    return const ShimmerReels();
                  } else if (state is ReelsError) {
                    return CustomErrorScreen(
                      onTap: () {
                        sl<ReelsBloc>().add(GetReels());
                      },
                    );
                  } else if (state is ReelsSuccess) {
                    return SafeArea(
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: storiesBloc.stories.isNotEmpty
                            ? Swiper(
                                controller: storiesBloc.controller,
                                itemCount: storiesBloc.stories.length,
                                loop: false,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return BodyReelsScreen(
                                    reelsModel: storiesBloc.stories[index],
                                    controller: storiesBloc.controller,
                                  );
                                },
                              )
                            : const CustomNoDataScreen(),
                      ),
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRouter.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.reels,
                    style: getBoldStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
