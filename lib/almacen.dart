  import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Almacen {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getLocalFile(String filename) async {
    final localPath = await _localPath;
    return File("$localPath/$filename");
  }

  Future<void> _createUserFileIfNotExists(String filename) async {
    final file = await _getLocalFile(filename);
    if (!file.existsSync()) {
      final emptyList = json.encode([]);
      await file.writeAsString(emptyList);
    }
  }

  Future<void> registerUser(String filename, Map<String, dynamic> userData) async {
    await _createUserFileIfNotExists(filename);

    try {
      final file = await _getLocalFile(filename);
      List<Map<String, dynamic>> userList = (await readUserList(filename)) ?? [];
      bool userExists = userList.any((user) => user['email'] == userData['email']);
      if (!userExists) {
        userList.add(userData);
        final jsonString = json.encode(userList);
        await file.writeAsString(jsonString);
      } else {
        throw Exception('Ya existe un usuario con el mismo correo electrónico.');
      }
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> readUserList(String filename) async {
    try {
      final file = await _getLocalFile(filename);
      final jsonString = await file.readAsString();
      final jsonData = json.decode(jsonString);
      if (jsonData is List) {
        return List<Map<String, dynamic>>.from(jsonData);
      }
    } catch (e) {
      // Lanza una excepción en lugar de devolver null
      throw Exception('Error al leer la lista de usuarios: $e');
    }
    return null;
  }
}
