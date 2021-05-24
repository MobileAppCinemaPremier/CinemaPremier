import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailEventStated extends DetailEvent {
  final int id;
  DetailEventStated(this.id);
  @override
  List<Object> get props => [];
}
