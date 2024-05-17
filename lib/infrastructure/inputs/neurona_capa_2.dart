import 'package:formz/formz.dart';

// Define input validation errors
enum NeuronaCapa2Error { empty, value, format  }

// Extend FormzInput and provide the input type and error type.
class NeuronaCapa2 extends FormzInput<int, NeuronaCapa2Error> {
  // Call super.pure to represent an unmodified form input.
  const NeuronaCapa2.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const NeuronaCapa2.dirty(int value ) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if(displayError == NeuronaCapa2Error.empty) return 'El campo es requerido';
    if(displayError == NeuronaCapa2Error.value) return 'El Valor tiene que estar Ser mayor a 0';
    if(displayError == NeuronaCapa2Error.format) return 'No tiene formato de numero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NeuronaCapa2Error? validator(int value) {

    if(value.toString().isEmpty || value.toString().trim().isEmpty) return NeuronaCapa2Error.empty;
    if(value <= 0) return NeuronaCapa2Error.value;

    final isInteger = int.tryParse( value.toString()) ?? -1;
    if(isInteger == -1) return NeuronaCapa2Error.format;

    return null;
  }
}