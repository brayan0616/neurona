

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) {
  return 1;
});

final salidaProvider = StateProvider<String?>((ref) {
  return null;
});

final activationFunctionsProvider = StateNotifierProvider<ActivationFunctionNotifier, List<String?>>((ref) {
  return ActivationFunctionNotifier();
});

class ActivationFunctionNotifier extends StateNotifier<List<String?>> {
  ActivationFunctionNotifier() : super(List.filled(4, null));  // Asume un máximo de 10 capas, ajusta según sea necesario

  void setFunction(int index, String? value) {
    state = List.from(state)..[index] = value;
  }
}