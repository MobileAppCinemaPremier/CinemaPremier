import 'package:cinema_premier/data/detail/detail_data.dart';
import 'package:equatable/equatable.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {}

class DetailLoaded extends DetailState {
  final Detail detail;
  const DetailLoaded(this.detail);
  @override
  List<Object> get props => [detail];
}
