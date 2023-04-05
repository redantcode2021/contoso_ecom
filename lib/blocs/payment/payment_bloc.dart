import 'package:bloc/bloc.dart';
import 'package:contoso_ecom/models/models.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethod>(_onPaymentMethod);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
  }

  void _onPaymentMethod(
    LoadPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      const PaymentLoaded(),
    );
  }

  void _onSelectPaymentMethod(
    SelectPaymentMethod event,
    Emitter<PaymentState> emit,
  ) {
    emit(
      PaymentLoaded(paymentMethod: event.paymentMethod),
    );
  }
}
