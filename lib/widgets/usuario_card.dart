// lib/widgets/usuario_card.dart
import 'package:flutter/material.dart';
import '../models/usuario.dart';

class UsuarioCard extends StatelessWidget {
  final Usuario usuario;

  UsuarioCard({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.correo),
      ),
    );
  }
}
