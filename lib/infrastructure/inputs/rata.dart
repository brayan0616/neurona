import 'package:formz/formz.dart';

// Define input validation errors
enum RataError { empty, value, format  }

// Extend FormzInput and provide the input type and error type.
class Rata extends FormzInput<double, RataError> {
  // Call super.pure to represent an unmodified form input.
  const Rata.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Rata.dirty(double value ) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if(displayError == RataError.empty) return 'El campo es requerido';
    if(displayError == RataError.value) return 'El Valor tiene que estar entre 0 y 1';
    if(displayError == RataError.format) return 'No tiene formato de numero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RataError? validator(double value) {

    if(value.toString().isEmpty || value.toString().trim().isEmpty) return RataError.empty;
    if(value< 0 || value > 1) return RataError.value;

    final isInteger = double.tryParse( value.toString()) ?? -1;
    if(isInteger == -1) return RataError.format;

    return null;
  }
}