import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neuronas/config/theme/app_theme.dart';
import 'package:neuronas/presentation/provider/counter_provider.dart';
import 'package:neuronas/presentation/provider/datos_provider.dart';
import 'package:neuronas/presentation/provider/form_provider.dart';
import 'package:neuronas/presentation/widgets/custom_text_field.dart';
import 'package:neuronas/presentation/widgets/matrix_data.dart';



void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Neuronas'),
        ),
        body: _HomeView()
      ),
      theme: AppTheme().getTheme(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<_HomeView> {

  final List<String> funcionActivacion = [
    'Simoide',
    'Tangente hiperbolica',
    'Seno',
    'Linea'
  ];
  

  String? selectedValue;
  
  @override
  Widget build(BuildContext context) {

    final neuronaForm = ref.watch(neuronaFormProvider);

    List<Function(int)> onChangedFunctions = [
      (value) => ref.read(neuronaFormProvider.notifier).onNeurona1Changed(value),
      (value) => ref.read(neuronaFormProvider.notifier).onNeurona2Changed(value),
      (value) => ref.read(neuronaFormProvider.notifier).onNeurona3Changed(value),
      // Añadir más funciones según sea necesario
    ];

    List<String?> errorMessages = [
      neuronaForm.neuronaCapa1.errorMessage,
      neuronaForm.neuronaCapa2.errorMessage,
      neuronaForm.neuronaCapa3.errorMessage,
      // Añadir más mensajes según sea necesario
    ];


    final text = Theme.of(context).textTheme;

    final conter = ref.watch(counterProvider);
    final  selectValues = ref.watch(activationFunctionsProvider);
    final salidaValue = ref.watch(salidaProvider);
    final fileState = ref.watch(fileProvider);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //! columna izq
          Container(
            width: 650,
            height: 750,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 147, 155, 248),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Text('Entrenamiento',style: text.bodyLarge,),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.tonalIcon(
                          onPressed: () {
                            ref.read(fileProvider.notifier).pickFile();
                          },
                          icon: const Icon(Icons.screen_search_desktop_sharp),
                          label: const Text('Cargando Datos')
                        ),
                        
                        const SizedBox(width: 10,),
                        const Text('Rata:'),
                        const SizedBox(width: 10,),
                        SizedBox(
                          height: 40,
                          width: 70,
                          child: Center(
                            child: CustomProductField(
                              isTopField: true,
                              isBottomField: true,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged:(value) => ref.read(neuronaFormProvider.notifier).onRataChanged(double.tryParse(value)??-1),
                              errorMessage: neuronaForm.rata.errorMessage,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        const Text('Error:'),
                        const SizedBox(width: 10,),
                        SizedBox(
                          height: 40,
                          width: 70,
                          child: CustomProductField(
                            isTopField: true,
                            isBottomField: true,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            onChanged:(value) => ref.read(neuronaFormProvider.notifier).onErrorChanged(double.tryParse(value)??-1),
                              errorMessage: neuronaForm.errorMaxPermit.errorMessage,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        const Text('Iteracciones:'),
                        const SizedBox(width: 10,),
                        
                        SizedBox(
                          height: 40,
                          width: 70,
                          child: CustomProductField(
                            isTopField: true,
                            isBottomField: true,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            onChanged:(value) => ref.read(neuronaFormProvider.notifier).onIteraccionesChanged(int.tryParse(value)??0),
                            errorMessage: neuronaForm.iteraciones.errorMessage,
                          ),
                        ),
                        
                      
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  
                  if(fileState.matrixData != null)
                    MatrixDisplay(matrix: fileState.matrixData!),
                  
                  const SizedBox(height: 10,),
                  const Text('Configuracion de Entrenamiento'),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Entradas: ${fileState.entradas ?? '0'}'),
                        const SizedBox(width: 10,),
                        Text('Salidas: ${fileState.salidas ?? '0'}'),
                        const SizedBox(width: 10,),
                        Text('Patrones: ${fileState.patrones ?? '0'}'),
                        const SizedBox(width: 10,),
                        Text('Seleccione cuantas capas de Neuronas: $conter'),
                        const SizedBox(width: 5,),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(conter>= 3)return;
                                ref.read(counterProvider.notifier).state++;
                              },
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Icon(Icons.arrow_upward_outlined, size: 10,),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            GestureDetector(
                              onTap: () {
                                if(conter<=1 )return;
                                ref.read(counterProvider.notifier).state--;
                              },
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Icon(Icons.arrow_downward_outlined, size: 10,),
                              ),
                            ),
                          ],
                        ),
                        
                        
                  
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),
                  
                  
                  if(conter > 0 ) ...[
                    for (int i = 0 ; i < conter; i++ ) ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: FadeInRight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cuantas neuronas en la Capa ${i + 1}'),
                            const SizedBox(width: 10,),
                            SizedBox(
                              height: 40,
                              width: 70,
                              child: CustomProductField(
                                isTopField: true,
                                isBottomField: true,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                onChanged: (value) => onChangedFunctions[i](int.parse(value)),
                                errorMessage: errorMessages[i],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    Icon(Icons.list),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Text('Seleccione una Funcion',style: TextStyle(fontSize: 14))
                                    )
                                  ],
                                ),
                                items: funcionActivacion.map((funcion) => DropdownMenuItem<String>(
                                  value: funcion,
                                  child: Text(funcion,style: const TextStyle(fontSize: 15),)
                                )).toList(),
                                value: selectValues[i],
                                onChanged: (value) {
                                  ref.read(activationFunctionsProvider.notifier).setFunction(i, value);
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 250,
                                  padding: const EdgeInsets.only(left: 14,right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.black26)
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.arrow_forward_ios_outlined),
                                  iconSize: 15,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 250,
                                  padding: const EdgeInsets.only( left: 14, right: 14 ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.black12)
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14,right: 14)
                                            
                                ),
                              )
                            ),
                          ],
                                                ),
                        ),
                      )
                      
                    }
                  ],
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Seleccione la Funcion para la capa de salida'),
                        const SizedBox(width: 10,),
                        DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Icon(Icons.list),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Text('Seleccione una Funcion',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,)
                                      )
                                    ],
                                  ),
                                  items: funcionActivacion.map((funcion) => DropdownMenuItem<String>(
                                    value: funcion,
                                    child: Text(funcion,style: const TextStyle(fontSize: 15),)
                                  )).toList(),
                                  value: salidaValue,
                                  onChanged: (value) {
                                    ref.read(salidaProvider.notifier).state = value;
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 250,
                                    padding: const EdgeInsets.only(left: 14,right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.black26)
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(Icons.arrow_forward_ios_outlined),
                                    iconSize: 15,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 250,
                                    padding: const EdgeInsets.only( left: 14, right: 14 ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.black12)
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding: EdgeInsets.only(left: 14,right: 14)
                      
                                  ),
                                )
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),

                  FilledButton.tonalIcon(
                    onPressed: () {
                      ref.read(neuronaFormProvider.notifier).onFormSubmit();
                    }, 
                    icon: const Icon(Icons.extension_rounded), 
                    label: const Text('Inociar entrenamiento')
                  ),

                  const SizedBox(height: 200,)
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
    
          //!columna derecha
          Container(
            width: 520,
            height: 750,
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(20)
            ),
            child: const Column(
              children: [
            
              ],
            ),
          ),
        ],
      ),
    );
  }
}
