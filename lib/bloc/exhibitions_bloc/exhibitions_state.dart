

import '../../models/exihibtions_model.dart';

abstract class ExhibitionsState {}

class ExhibitionsLoading extends ExhibitionsState {}

class ExhibitionsError extends ExhibitionsState {
  String error;
  ExhibitionsError(this.error);
}

class ExhibitionsSuccess extends ExhibitionsState {
  List<ExhibitionsModel> exhibitionsList;

  ExhibitionsSuccess(this.exhibitionsList);
}
