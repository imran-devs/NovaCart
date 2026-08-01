import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<String> {
  PaymentCubit() : super("COD");

  void changePayment(String payment) {
    emit(payment);
  }
}
