import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:3000"; // Cambia esto por la IP de tu servidor si es necesario

  Future<List<dynamic>> obtenerUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  Future<Map<String, dynamic>> agregarUsuario(String nombre, String correo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "correo": correo,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al agregar el usuario');
    }
  }
}
