import 'dart:io';
import 'package:neuronas/domain/datasources/neurona_datasource.dart';
import 'package:file_picker/file_picker.dart';

class NeuronaDatasourceImpl extends NeuronaDatasource {
  @override
  Future<File?> pickFile() async{

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result != null){
      return File(result.files.single.path!);
    }

    return null;

  }
  
  
}