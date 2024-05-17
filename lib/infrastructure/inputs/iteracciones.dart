import 'package:formz/formz.dart';

// Define input validation errors
enum IteracionesError { empty, value, format  }

// Extend FormzInput and provide the input type and error type.
class Iteraciones extends FormzInput<int, IteracionesError> {
  // Call super.pure to represent an unmodified form input.
  const Iteraciones.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Iteraciones.dirty(int value ) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if(displayError == IteracionesError.empty) return 'El campo es requerido';
    if(displayError == IteracionesError.value) return 'El Valor tiene que estar Ser mayor a 0';
    if(displayError == IteracionesError.format) return 'No tiene formato de numero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  IteracionesError? validator(int value) {

    if(value.toString().isEmpty || value.toString().trim().isEmpty) return IteracionesError.empty;
    if(value <= 0) return IteracionesError.value;

    final isInteger = int.tryParse( value.toString()) ?? -1;
    if(isInteger == -1) return IteracionesError.format;

    return null;
  }
}