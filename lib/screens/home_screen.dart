// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/usuario.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  late Future<List<Usuario>> usuarios;

  @override
  void initState() {
    super.initState();
    usuarios = api.obtenerUsuarios().then(
          (data) => data.map((item) => Usuario.fromJson(item)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuarios')),
      body: FutureBuilder<List<Usuario>>(
        future: usuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final usuario = snapshot.data![index];
                return ListTile(
                  title: Text(usuario.nombre),
                  subtitle: Text(usuario.correo),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await api.agregarUsuario('Nuevo Usuario', 'nuevo@correo.com');
          setState(() {
            usuarios = api.obtenerUsuarios().then(
                  (data) => data.map((item) => Usuario.fromJson(item)).toList(),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
