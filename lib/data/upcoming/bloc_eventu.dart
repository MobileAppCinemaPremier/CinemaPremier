import 'package:equatable/equatable.dart';

abstract class UpcomingEvent extends Equatable {
  const UpcomingEvent();
}

class UpcomingEventStart extends UpcomingEvent {
  final int upcomingId;
  final String query;
  const UpcomingEventStart(this.upcomingId, this.query);

  @override
  List<Object> get props => [];
}
