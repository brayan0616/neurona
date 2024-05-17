import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileProvider = StateNotifierProvider<FileNotifier, FileState>((ref) {
  return FileNotifier();
});


class FileNotifier extends StateNotifier<FileState> {
  FileNotifier() : super(FileState());

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        state = state.copyWith(file: file, message: 'El archivo se obtuvo correctamente');
        // state = FileState(file: file, message: 'El archivo se obtuvo correctamente');
        await porcessFileData(file);
      } else {
        state = state.copyWith(message: 'No se selecciono ningun archivo', hasError: true);
        // state = FileState(message: 'No se seleccionó ningún archivo', hasError: true);
      }
    } catch (e) {
      state = state.copyWith(message: 'Error al obtener el archivo: ${e.toString()}', hasError: true);
      // state = FileState(message: 'Error al obtener el archivo: ${e.toString()}', hasError: true);
    }
  }


  Future<void> porcessFileData (File file) async{
    try {
      String content = await file.readAsString();

      List<List<String>> matrix = content.split('\n').map((linea) => linea.split(' ')).toList();
      final entradas = matrix.first.where((title) => title.startsWith('X')).length;
      final salidas = matrix.first.where((title) => title.contains('YD')).length;
      final patrones = matrix.length - 1;
      state = state.copyWith(
        matrixData: matrix,
        entradas: entradas,
        salidas: salidas,
        patrones: patrones
      );
    } catch (e) {
      state = state.copyWith(message: 'Error procesando los datos del archivo: ${e.toString()}', hasError: true);
    }
  }
}


class FileState {
  final File? file;
  final String message;
  final bool hasError;
  final List<List<String>>? matrixData;
  final int? entradas;
  final int? salidas;
  final int? patrones;

  FileState({
    this.file, 
    this.message = '', 
    this.hasError = false,
    this.matrixData,
    this.entradas,
    this.salidas,
    this.patrones,
  });

  FileState copyWith({
    File? file,
    String? message,
    bool? hasError,
    List<List<String>>? matrixData,
    int? entradas,
    int? salidas,
    int? patrones,
  }) => FileState(
    file: file ?? this.file ,
    message: message ?? this.message ,
    hasError: hasError ?? this.hasError ,
    matrixData: matrixData ?? this.matrixData,
    entradas: entradas ?? this.entradas,
    salidas: salidas ?? this.salidas,
    patrones: patrones ?? this.patrones,
  );
}