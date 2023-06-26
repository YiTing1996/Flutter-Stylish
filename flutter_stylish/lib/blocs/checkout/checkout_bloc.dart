import 'package:flutter_stylish/helper/export/bloc_export.dart';

// https://www.youtube.com/watch?v=A5oHdgCqGqM&ab_channel=MaxonFlutter
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoadingState()) {
    on<CheckoutInitialEvent>(_onLoadCheckout);
    on<UpdateCheckoutEvent>(_onUpdateCheckout);
  }

  void _onLoadCheckout(
      CheckoutInitialEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoadedState());
  }

  void _onUpdateCheckout(
    UpdateCheckoutEvent event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoadedState) {
      final state = this.state as CheckoutLoadedState;
      emit(
        CheckoutLoadedState(
          email: event.email ?? state.email,
          fullName: event.fullName ?? state.fullName,
          address: event.address ?? state.address,
          phone: event.phone ?? state.phone,
          cardNumber: event.cardNumber ?? state.cardNumber,
          dueYear: event.dueYear ?? state.dueYear,
          dueMonth: event.dueMonth ?? state.dueMonth,
          ccv: event.ccv ?? state.ccv,
        ),
      );
    }
  }
}
