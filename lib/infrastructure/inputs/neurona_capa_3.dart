import 'package:formz/formz.dart';

// Define input validation errors
enum NeuronaCapa3Error { empty, value, format  }

// Extend FormzInput and provide the input type and error type.
class NeuronaCapa3 extends FormzInput<int, NeuronaCapa3Error> {
  // Call super.pure to represent an unmodified form input.
  const NeuronaCapa3.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const NeuronaCapa3.dirty(int value ) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if(displayError == NeuronaCapa3Error.empty) return 'El campo es requerido';
    if(displayError == NeuronaCapa3Error.value) return 'El Valor tiene que estar Ser mayor a 0';
    if(displayError == NeuronaCapa3Error.format) return 'No tiene formato de numero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NeuronaCapa3Error? validator(int value) {

    if(value.toString().isEmpty || value.toString().trim().isEmpty) return NeuronaCapa3Error.empty;
    if(value <= 0) return NeuronaCapa3Error.value;

    final isInteger = int.tryParse( value.toString()) ?? -1;
    if(isInteger == -1) return NeuronaCapa3Error.format;

    return null;
  }
}