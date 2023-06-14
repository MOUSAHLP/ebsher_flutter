import 'package:equatable/equatable.dart';

import '../../models/reels_model.dart';
abstract class ReelsState {}
class ReelsLoading extends ReelsState {}
class ReelsSuccess extends ReelsState {
  List<ReelsModel> listReels;

  ReelsSuccess(this.listReels);
}
class ReelsError extends ReelsState {
  String error;

  ReelsError(this.error);
}
