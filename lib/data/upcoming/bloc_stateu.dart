import 'package:cinema_premier/data/upcoming/upcoming_data.dart';
import 'package:equatable/equatable.dart';

abstract class UpcomingState extends Equatable {
  const UpcomingState();

  @override
  List<Object> get props => [];
}

class UpcomingLoading extends UpcomingState {}

class UpcomingLoaded extends UpcomingState {
  final List<Upcoming> upcomingList;
  const UpcomingLoaded(this.upcomingList);
  @override
  List<Object> get props => [upcomingList];
}

class UpcomingLoadFailed extends UpcomingState {}
