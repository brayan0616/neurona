import 'package:flutter/material.dart';

class MatrixDisplay extends StatelessWidget {

  final List<List<String>> matrix;

  const MatrixDisplay({super.key, required this.matrix});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _createColumns(), 
        rows: _createRows()),
    );
  }

  List<DataColumn> _createColumns() {
    
    return matrix.isNotEmpty
      ? matrix.first.map((header) => DataColumn(label: Text(header))).toList()
      : [];
  }

  List<DataRow> _createRows() {
    return matrix.isNotEmpty
        ? matrix.sublist(1).map((row) => DataRow(
            cells: row.map((cell) => DataCell(Text(cell))).toList()
          )).toList()
        : [];
  }

}
