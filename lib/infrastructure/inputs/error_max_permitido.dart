import 'package:formz/formz.dart';

// Define input validation errors
enum ErrorMaxPermitError { empty, value, format  }

// Extend FormzInput and provide the input type and error type.
class ErrorMaxPermit extends FormzInput<double, ErrorMaxPermitError> {
  // Call super.pure to represent an unmodified form input.
  const ErrorMaxPermit.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const ErrorMaxPermit.dirty(double value ) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if(displayError == ErrorMaxPermitError.empty) return 'El campo es requerido';
    if(displayError == ErrorMaxPermitError.value) return 'El Valor tiene que estar entre 0 y 1';
    if(displayError == ErrorMaxPermitError.format) return 'No tiene formato de numero';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ErrorMaxPermitError? validator(double value) {

    if(value.toString().isEmpty || value.toString().trim().isEmpty) return ErrorMaxPermitError.empty;
    if(value< 0 || value > 1) return ErrorMaxPermitError.value;

    final isInteger = double.tryParse( value.toString()) ?? -1;
    if(isInteger == -1) return ErrorMaxPermitError.format;

    return null;
  }
}