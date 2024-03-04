import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetVendorsExhibitionsParams extends Equatable {
  int? exhibitionsId;
  int? skipCount;
  int? maxCount;

  GetVendorsExhibitionsParams({
    this.exhibitionsId,
    this.skipCount,
    this.maxCount,

  });

  Map<String, dynamic> toJson() => {

        "event_id": exhibitionsId,
        "skipCount": skipCount,
        "maxCount": maxCount,

      };

  factory GetVendorsExhibitionsParams.fromGetVendorsParams(GetVendorsExhibitionsParams params) =>
      GetVendorsExhibitionsParams(
        exhibitionsId: params.exhibitionsId,

        skipCount: params.skipCount,
        maxCount: params.maxCount,
      );

  GetVendorsExhibitionsParams setNewSortingValue(
      {required GetVendorsExhibitionsParams getVendorsParams}) {
    return GetVendorsExhibitionsParams(
      exhibitionsId: getVendorsParams.exhibitionsId ?? exhibitionsId,

      ///PAGENATION
      maxCount: getVendorsParams.maxCount ?? maxCount,
      skipCount: getVendorsParams.skipCount ?? skipCount,
    );
  }

  GetVendorsExhibitionsParams setNewFilteringValues(
      {required GetVendorsExhibitionsParams getVendorsParams}) {
    return GetVendorsExhibitionsParams(
      exhibitionsId: exhibitionsId,

      ///PAGENATION
      maxCount: maxCount,
      skipCount: skipCount,
    );
  }

  GetVendorsExhibitionsParams copyWith({
    int? subCategoryId,
    int? skipCount,
    int? maxCount,
  }) {
    return GetVendorsExhibitionsParams(
      exhibitionsId: subCategoryId ?? this.exhibitionsId,




      ///PAGENATION
      maxCount: maxCount ?? this.maxCount,
      skipCount: skipCount ?? this.skipCount,
    );
  }

  @override
  List<Object?> get props => [
        exhibitionsId,
        maxCount,
        skipCount,

      ];
}
