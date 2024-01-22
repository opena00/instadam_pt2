// configuration_page.dart
import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _darkMode = !_darkMode;
                });
              },
              child: Text(_darkMode ? 'Desactivar Modo Oscuro' : 'Activar Modo Oscuro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para eliminar la cuenta
                // Puedes mostrar un cuadro de diálogo de confirmación antes de eliminar la cuenta
              },
              child: Text('Eliminar Cuenta'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón que no hace nada
              },
              child: Text('Botón Inactivo'),
            ),
          ],
        ),
      ),
    );
  }
}
