// pagina_principal.dart
import 'package:flutter/material.dart';
import 'package:instadam_pt2/main.dart';
import 'package:instadam_pt2/Posting.dart';
import 'package:instadam_pt2/postcard.dart';
import 'package:instadam_pt2/configuracion.dart';
class PaginaPrincipal extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PaginaPrincipal> {
  List<Post> posts = [
    Post(
      username: 'opena00',
      image: AssetImage('Assets/imagen1.jpg'), // Assuming your assets are in the 'assets' folder
      caption: 'La Horita de los traumas',
    ),
    Post(
      username: 'opena00',
      image: AssetImage('Assets/imagen2.jpg'), // Replace 'URL_IMAGEN_2' with the actual URL
      caption: 'Top 10 cosplays del mundo',
    ),
    // Add more posts as needed
    Post(
      username: 'opena00',
      image: AssetImage('Assets/imagen3.jpg'), // Replace 'URL_IMAGEN_3' with the actual URL
      caption: 'Monke',
    ),
    Post(
      username: 'opena00',
      image: AssetImage('Assets/imagen4.jpg'), // Replace 'URL_IMAGEN_4' with the actual URL
      caption: 'Un chef a entrado muy subido al trabajo',
    ),
  ];

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Cerrar Sesión?'),
          content: Text('¿Estás seguro de que deseas cerrar la sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                _signOut; // Llama a la función para cerrar sesión sin paréntesis
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }


  void _signOut() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("opena00"),
              accountEmail: Text("oscarpenacastellano@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil de usuario'),
              onTap: () {
                // Agregar la lógica de navegación para el perfil de usuario
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                // Agregar la lógica de navegación para la configuración
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Galería de imágenes'),
              onTap: () {
                // Agregar la lógica de navegación para la galería de imágenes
              },
            ),
            // Puedes agregar más elementos de menú si es necesario
            Expanded(child: SizedBox()), // Espacio flexible
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                _confirmSignOut(context); // Muestra el cuadro de diálogo de confirmación
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}
