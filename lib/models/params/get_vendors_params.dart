import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetVendorsParams extends Equatable {
  int? subCategoryId;
  bool? isOpen;
  double? lat;
  double? lon;
  int? categoryId;
  int? rate;
  int? skipCount;
  int? maxCount;
  bool? sortByName;
  bool? recent;
  bool? visits;

  GetVendorsParams({
    this.subCategoryId,
    this.isOpen,
    this.lat,
    this.lon,
    this.categoryId,
    this.rate,
    this.skipCount,
    this.maxCount,
    this.sortByName,
    this.recent,
    this.visits,
  });

  Map<String, dynamic> toJson() => {
        "is_active":1,
        "subcategories[]": subCategoryId,
        "is_open": isOpen == null
            ? null
            : isOpen!
                ? 1
                : 0,
        "latitude": lat,
        "longitude": lon,
        "category_id": categoryId,
        "rate": rate,
        "skip_count":skipCount,
        "max_count":maxCount,
        "sort_by_name": sortByName == null
            ? null
            : sortByName!
                ? 1
                : 0,
        "recent": recent == null
            ? null
            : recent!
                ? 1
                : 0,
        "visits": visits == null
            ? null
            : visits!
                ? 1
                : 0,
      };

  factory GetVendorsParams.fromGetVendorsParams(GetVendorsParams params) =>
      GetVendorsParams(
        subCategoryId: params.subCategoryId,
        isOpen: params.isOpen,
        lat: params.lat,
        lon: params.lon,
        categoryId: params.categoryId,
        rate: params.rate,
        skipCount: params.skipCount,
        maxCount: params.maxCount,
        sortByName: params.sortByName,
        recent: params.recent,
        visits: params.visits,
      );

  GetVendorsParams setNewSortingValue(
      {required GetVendorsParams getVendorsParams}) {
    return GetVendorsParams(
      subCategoryId: getVendorsParams.subCategoryId ?? subCategoryId,
      categoryId: getVendorsParams.categoryId ?? categoryId,

      ///FILTERING
      isOpen: getVendorsParams.isOpen ?? isOpen,
      lat: getVendorsParams.lat ?? lat,
      lon: getVendorsParams.lon ?? lon,
      rate: getVendorsParams.rate ?? rate,

      /// SORTING
      recent: getVendorsParams.recent,
      visits: getVendorsParams.visits,
      sortByName: getVendorsParams.sortByName,

      ///PAGENATION
      maxCount: getVendorsParams.maxCount ?? maxCount,
      skipCount: getVendorsParams.skipCount ?? skipCount,
    );
  }

  GetVendorsParams setNewFilteringValues(
      {required GetVendorsParams getVendorsParams}) {
    return GetVendorsParams(
      subCategoryId: subCategoryId,
      categoryId: categoryId,

      ///FILTERING
      isOpen: getVendorsParams.isOpen,
      lat: getVendorsParams.lat,
      lon: getVendorsParams.lon,
      rate: getVendorsParams.rate,

      /// SORTING
      recent: recent,
      visits: visits,
      sortByName: sortByName,

      ///PAGENATION
      maxCount: maxCount,
      skipCount: skipCount,
    );
  }

  GetVendorsParams copyWith({
    int? subCategoryId,
    required bool? isOpen,
    required double? lat,
    required double? lon,
    int? categoryId,
    required int? rate,
    int? skipCount,
    int? maxCount,
    bool? sortByName,
    bool? recent,
    bool? visits,
  }) {
    return GetVendorsParams(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      categoryId: categoryId ?? this.categoryId,

      ///FILTERING
      isOpen: isOpen,
      lat: lat,
      lon: lon,
      rate: rate,

      /// SORTING
      recent: recent ?? this.recent,
      visits: visits ?? this.visits,
      sortByName: sortByName ?? this.sortByName,

      ///PAGENATION
      maxCount: maxCount ?? this.maxCount,
      skipCount: skipCount ?? this.skipCount,
    );
  }

  @override
  List<Object?> get props => [
        subCategoryId,
        categoryId,
        isOpen,
        lat,
        lon,
        rate,
        recent,
        visits,
        sortByName,
        maxCount,
        skipCount,
      ];
}
