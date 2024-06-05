import 'package:flutter_bloc/flutter_bloc.dart';

part 'paywall_event.dart';
part 'paywall_state.dart';

class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  PaywallBloc() : super(PaywallInitial()) {
    on<PaywallEvent>((event, emit) {});
  }
}
