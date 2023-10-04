import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetSearchParams extends Equatable {
  String? textSearch;
  int? skipCount;
  int? maxCount;
  GetSearchParams({
    this.textSearch,
    this.skipCount,
    this.maxCount,
  });

  Map<String, dynamic> toJson() => {
        "is_active": 1,
        "keyword": textSearch,
        "skip_count": skipCount,
        "max_count": maxCount,
      };

  factory GetSearchParams.fromGetVendorsParams(GetSearchParams params) =>
      GetSearchParams(
        textSearch: params.textSearch,
        skipCount: params.skipCount,
        maxCount: params.maxCount,
      );

  GetSearchParams setNewSortingValue(
      {required GetSearchParams getVendorsParams}) {
    return GetSearchParams(
      textSearch: getVendorsParams.textSearch ?? textSearch,

      ///PAGENATION
      maxCount: getVendorsParams.maxCount ?? maxCount,
      skipCount: getVendorsParams.skipCount ?? skipCount,
    );
  }

  GetSearchParams setNewFilteringValues(
      {required GetSearchParams getVendorsParams}) {
    return GetSearchParams(
      textSearch: textSearch,

      ///PAGENATION
      maxCount: maxCount,
      skipCount: skipCount,
    );
  }

  GetSearchParams copyWith({
    String? textSearch,
    int? skipCount,
    int? maxCount,
  }) {
    return GetSearchParams(
      textSearch: textSearch ?? this.textSearch,

      ///PAGENATION
      maxCount: maxCount ?? this.maxCount,
      skipCount: skipCount ?? this.skipCount,
    );
  }

  @override
  List<Object?> get props => [
        textSearch,
        maxCount,
        skipCount,
      ];
}
