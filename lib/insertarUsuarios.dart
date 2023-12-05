import 'dart:convert';
import 'listarUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertarUsuarios extends StatefulWidget {
  const InsertarUsuarios({Key? key}) : super(key: key);

  @override
  State<InsertarUsuarios> createState() => _InsertarUsuariosState();
}

class _InsertarUsuariosState extends State<InsertarUsuarios> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController horasreparacionController =
      TextEditingController();
  final TextEditingController precioreparacionController =
      TextEditingController();
  final TextEditingController observacionesController = TextEditingController();

  Future<void> insertarProducto() async {
    final nuevoProducto = {
      'id': idController.text,
      'placa': placaController.text,
      'horasreparacion': double.parse(horasreparacionController.text),
      'precioreparacion': int.parse(precioreparacionController.text),
      'observaciones': observacionesController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://examenapi2.onrender.com/api/productos'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(nuevoProducto),
      );

      if (response.statusCode == 200) {
        print('Nuevo Vehiculo insertado: $nuevoProducto');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vehiculo insertado correctamente.'),
            backgroundColor: Colors.purple,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListarUsuarios(),
          ),
        );
      } else {
        print(
            'Error al insertar el Vehiculo. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }

    idController.clear();
    placaController.clear();
    horasreparacionController.clear();
    precioreparacionController.clear();
    observacionesController.clear();
  }

  bool camposObligatoriosLlenos() {
    return idController.text.isNotEmpty &&
        placaController.text.isNotEmpty &&
        horasreparacionController.text.isNotEmpty &&
        precioreparacionController.text.isNotEmpty &&
        observacionesController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar nuevo Vehiculo'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'ID',
                prefixIcon: Icon(Icons.info_outline),
              ),
            ),
            TextField(
              controller: placaController,
              decoration: const InputDecoration(
                labelText: 'Placa',
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            TextField(
              controller: horasreparacionController,
              decoration: const InputDecoration(
                labelText: 'Horas reparacion',
                prefixIcon: Icon(Icons.watch),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: precioreparacionController,
              decoration: const InputDecoration(
                labelText: 'Precio reparacion',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: observacionesController,
              decoration: const InputDecoration(
                labelText: 'Observaciones',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (camposObligatoriosLlenos()) {
                  insertarProducto();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Por favor, complete todos los campos obligatorios.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Insertar Vehiculo'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(0, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
