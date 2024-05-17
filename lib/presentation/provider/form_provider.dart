import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:neuronas/infrastructure/inputs/Error_max_permitido.dart';
import 'package:neuronas/infrastructure/inputs/iteracciones.dart';
import 'package:neuronas/infrastructure/inputs/neurona_capa_1.dart';
import 'package:neuronas/infrastructure/inputs/neurona_capa_2.dart';
import 'package:neuronas/infrastructure/inputs/neurona_capa_3.dart';
import 'package:neuronas/infrastructure/inputs/rata.dart';

final neuronaFormProvider = StateNotifierProvider<NeuronaFormNotifier,NeuronaFormState>((ref) {
  return NeuronaFormNotifier();
});

class NeuronaFormNotifier extends StateNotifier<NeuronaFormState> {

  final void Function(Map<String,dynamic> neuronaLike)? onSubmitCallback;

  NeuronaFormNotifier({
    this.onSubmitCallback
  }): super(NeuronaFormState());

  bool onFormSubmit() {
    _touchedEverything();

    if(!state.isFormValid) return false;

    // if(onSubmitCallback == null) return false;

    final neuronaLike = {
      'rata': state.rata.value,
      'error': state.errorMaxPermit.value,
      'iteraciones': state.iteraciones.value,
      'neuronaCapa1': state.neuronaCapa1.value,
      'neuronaCapa2': state.neuronaCapa2.value,
      'neuronaCapa3': state.neuronaCapa3.value
    };


    return true;
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Rata.dirty(state.rata.value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])
    );
  }

  void onRataChanged(double value) {
    state = state.copyWith(
      rata: Rata.dirty(value),
      isFormValid: Formz.validate([
        Rata.dirty(value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])

    );
  }
  void onErrorChanged(double value) {
    state = state.copyWith(
      errorMaxPermit: ErrorMaxPermit.dirty(value),
      isFormValid: Formz.validate([
        ErrorMaxPermit.dirty(value),
        Rata.dirty(state.rata.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])

    );
  }

  void onIteraccionesChanged(int value) {
    state = state.copyWith(
      iteraciones: Iteraciones.dirty(value),
      isFormValid: Formz.validate([
        Iteraciones.dirty(value),
        Rata.dirty(state.rata.value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])

    );
  }

  void onNeurona1Changed(int value) {
    state = state.copyWith(
      neuronaCapa1: NeuronaCapa1.dirty(value),
      isFormValid: Formz.validate([
        NeuronaCapa1.dirty(value),
        Rata.dirty(state.rata.value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])

    );
  }

  void onNeurona2Changed(int value) {
    state = state.copyWith(
      neuronaCapa2: NeuronaCapa2.dirty(value),
      isFormValid: Formz.validate([
        NeuronaCapa2.dirty(value),
        Rata.dirty(state.rata.value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
        NeuronaCapa3.dirty(state.neuronaCapa3.value),
      ])

    );
  }


  void onNeurona3Changed(int value) {
    state = state.copyWith(
      neuronaCapa3: NeuronaCapa3.dirty(value),
      isFormValid: Formz.validate([
        NeuronaCapa3.dirty(value),
        Rata.dirty(state.rata.value),
        ErrorMaxPermit.dirty(state.errorMaxPermit.value),
        Iteraciones.dirty(state.iteraciones.value),
        NeuronaCapa2.dirty(state.neuronaCapa2.value),
        NeuronaCapa1.dirty(state.neuronaCapa1.value),
      ])

    );
  }
  






  
}






class NeuronaFormState {
  final bool isFormValid;
  final Rata rata;
  final ErrorMaxPermit errorMaxPermit;
  final Iteraciones iteraciones;
  final NeuronaCapa1 neuronaCapa1;
  final NeuronaCapa2 neuronaCapa2;
  final NeuronaCapa3 neuronaCapa3;

  NeuronaFormState({
    this.isFormValid = false,
    this.rata = const Rata.dirty(0),
    this.errorMaxPermit = const ErrorMaxPermit.dirty(0),
    this.iteraciones = const Iteraciones.dirty(0),
    this.neuronaCapa1 = const NeuronaCapa1.dirty(0),
    this.neuronaCapa2 = const NeuronaCapa2.dirty(0),
    this.neuronaCapa3 = const NeuronaCapa3.dirty(0),
  });

  NeuronaFormState copyWith({
    bool? isFormValid,
    Rata? rata,
    ErrorMaxPermit? errorMaxPermit,
    Iteraciones? iteraciones,
    NeuronaCapa1? neuronaCapa1,
    NeuronaCapa2? neuronaCapa2,
    NeuronaCapa3? neuronaCapa3,
  }) => NeuronaFormState(
    isFormValid : isFormValid ?? this.isFormValid,
    rata : rata ?? this.rata,
    errorMaxPermit : errorMaxPermit ?? this.errorMaxPermit,
    iteraciones : iteraciones ?? this.iteraciones,
    neuronaCapa1 : neuronaCapa1 ?? this.neuronaCapa1,
    neuronaCapa2 : neuronaCapa2 ?? this.neuronaCapa2,
    neuronaCapa3 : neuronaCapa3 ?? this.neuronaCapa3,
  );

  
}