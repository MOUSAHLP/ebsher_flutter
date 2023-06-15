import 'package:absher/bloc/vendor_details_bloc/vendor_details_state.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/collapsed_header.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/expanded_header.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/vendor_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/vendor_details_bloc/vendor_details_bloc.dart';
import '../../../bloc/vendor_details_bloc/vendor_details_event.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../edit_profile_screen/widgets/build_shimmer_profile.dart';

class VendorDetailsScreen extends StatelessWidget {
  VendorDetailsScreen({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorDetailsBloc>(
        create: (BuildContext context) =>
            sl<VendorDetailsBloc>()..add(getVendorDetails(id)),
        // lazy: false,
        child: VendorDetailsScreenBody(
          id: id,
        ));
  }
}

class VendorDetailsScreenBody extends StatefulWidget {
  VendorDetailsScreenBody({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  State<VendorDetailsScreenBody> createState() =>
      _VendorDetailsScreenBodyState();
}

class _VendorDetailsScreenBodyState extends State<VendorDetailsScreenBody> {
  ScrollController? _scrollController;
  bool lastStatus = true;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (1.sw - 96);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(

      child: BlocBuilder<VendorDetailsBloc, VendorDetailsState>(
          builder: (context, state) {
        if (state is VendorDetailsLoading) {
          return Center(child: CircularProgressIndicator(
            color: ColorManager.primaryColor,
          ));
        } else if (state is VendorDetailsError) {
          return CustomErrorScreen(
            onTap: () {
              sl<VendorDetailsBloc>().add(getVendorDetails(widget.id));
            },
          );
        } else if (state is VendorDetailsSuccess) {
          return Scaffold(
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 1.sw + 10,
                      toolbarHeight: 86,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: ExpandedHeader(
                          vendor: state.vendorModel,
                        ),
                      ),
                      actions: _isShrink
                          ? [
                              CollapsedHeader(
                                toolbarHeight: 86,
                                vendor: state.vendorModel,
                              ),
                            ]
                          : [Container()],
                    ),
                  ];
                },
                body: VendorDetailsBody(
                  vendor: state.vendorModel,
                ),
              ),
            ),
          );
        } else {
          return Text("");
        }
      }),
    );
  }
}
