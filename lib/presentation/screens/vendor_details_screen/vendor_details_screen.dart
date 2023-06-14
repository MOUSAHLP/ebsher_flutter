import 'package:absher/models/vendor_model.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/collapsed_header.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/expanded_header.dart';
import 'package:absher/presentation/screens/vendor_details_screen/widgets/vendor_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorDetailsScreen extends StatefulWidget {
  const VendorDetailsScreen({Key? key, required this.vendor}) : super(key: key);
  final VendorModel vendor;

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
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
                    vendor: widget.vendor,
                  ),
                ),
                actions: _isShrink
                    ? [
                        CollapsedHeader(
                          toolbarHeight: 86,
                          vendor: widget.vendor,
                        ),
                      ]
                    : [Container()],
              ),
            ];
          },
          body: VendorDetailsBody(
            vendor: widget.vendor,
          ),
        ),
      ),
    );
  }
}
