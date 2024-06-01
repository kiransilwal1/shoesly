part of 'filter_count_bloc.dart';

sealed class FilterCountEvents {}

final class AddFilterEvent extends FilterCountEvents {
  final int count;
  AddFilterEvent(this.count);
}

final class SubstractCountEvent extends FilterCountEvents {
  final int count;
  SubstractCountEvent(this.count);
}
