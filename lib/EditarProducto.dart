import 'package:flutter/material.dart';

class EditarProducto extends StatefulWidget {
  final Map<String, dynamic> producto;

  const EditarProducto({Key? key, required this.producto}) : super(key: key);

  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  late TextEditingController placaController;
  late TextEditingController horasreparacionController;
  late TextEditingController precioreparacionController;
  late TextEditingController observacionesController;
  

  @override
  void initState() {
    super.initState();
    placaController = TextEditingController(text: widget.producto['placa']);
    horasreparacionController =
        TextEditingController(text: widget.producto['horasreparacion'].toString());
    precioreparacionController =
        TextEditingController(text: widget.producto['precioreparacion'].toString());
    observacionesController =
        TextEditingController(text: widget.producto['observaciones']);
   
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Vehiculo'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: placaController,
              decoration: const InputDecoration(labelText: 'Placa'),
            ),
            TextField(
              controller: horasreparacionController,
              decoration: const InputDecoration(labelText: 'Horas de reparacion'),
            ),
            TextField(
              controller: precioreparacionController,
              decoration: const InputDecoration(labelText: 'Precio de reparacion'),
            ),
            TextField(
              controller: observacionesController,
              decoration: const InputDecoration(labelText: 'Observaciones '),
            ),
            
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final nuevosValores = {
              'placa': placaController.text,
              'horasreparacion': double.parse(horasreparacionController.text),
              'precioreparacion': int.parse(precioreparacionController.text),
              'observaciones': observacionesController.text,
             
            };
            Navigator.of(context).pop(nuevosValores);
          },
          child: const Text('Guardar cambios'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ],
    );
  }
}
