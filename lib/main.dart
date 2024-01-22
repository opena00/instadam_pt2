import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:instadam_pt2/almacen.dart';
import 'package:instadam_pt2/paginaPrincipal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            minimumSize: Size(280.0, 40.0),
          ),
        ),
      ),
    );
  }
}

class LoginCheck {
  Future<bool> isLoginValid(String email, String password) async {
    try {
      final storage = Almacen();
      final userList = await storage.readUserList('user_data.json');
      if (userList != null) {
        for (var userData in userList) {
          if (userData['email'] == email && userData['password'] == password) {
            return true; // Inicio de sesión exitoso
          }
        }
      }
    } catch (e) {
      print('Error al verificar el inicio de sesión: $e');
    }

    return false; // Inicio de sesión fallido
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Image.asset('Assets/logo.png'), // Ruta de la imagen de logotipo
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Correo Electrónico',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;

                final loginChecker = LoginCheck();
                final loginSuccessful = await loginChecker.isLoginValid(email, password);

                if (loginSuccessful) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginaPrincipal()),
                  );
                } else {
                  print('La autenticación falló. Comprueba las credenciales.');
                }
              },
              child: Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('¿No tienes una cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('Assets/logo.png'), // Ruta de la imagen de logotipo
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Nombre de usuario',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Correo Electrónico',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final username = usernameController.text;
                final email = emailController.text;
                final password = passwordController.text;

                final registerChecker = RegisterCheck();
                final userAlreadyExists = await registerChecker.doesUserExist(email);

                if (userAlreadyExists) {
                  _showRegistrationError(context, 'Ya  un usuario con el mismo correo electrónico.');
                } else {
                  if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                    final data = {
                      'username': username,
                      'email': email,
                      'password': password,
                    };

                    final storage = Almacen();
                    await storage.registerUser('user_data.json', data);

                    _showRegistrationSuccess(context, 'Registro exitoso. Inicia sesión manualmente.');
                  } else {
                    print('Por favor, complete todos los campos.');
                  }
                }
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRegistrationError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error de registro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showRegistrationSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registro exitoso'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

class RegisterCheck {
  Future<bool> doesUserExist(String email) async {
    try {
      final storage = Almacen();
      final userList = await storage.readUserList('user_data.json');
      if (userList != null) {
        for (var userData in userList) {
          if (userData['email'] == email) {
            return true;
          }
        }
      }
    } catch (e) {
      print('Error al verificar la existencia del usuario: $e');
    }
    return false;
  }
}
