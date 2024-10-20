import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Título de "INICIO DE SESIÓN"
                      Text(
                        'INICIO DE SESIÓN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 30),

                      // Logo
                      Image.asset(
                        'assets/logo.png',
                        height: 100,
                      ),
                      SizedBox(height: 40),

                      // Campo de correo
                      _buildInputField('CORREO ELECTRONICO', 'herbascaceres@gmail.com', Icons.email),
                      SizedBox(height: 20),

                      // Campo de contraseña
                      _buildInputField('CONTRASEÑA', 'Introduce aca la contraseña', Icons.lock, isPassword: true),
                      SizedBox(height: 30),

                      // Botón de inicio de sesión mejorado
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'INICIAR SESIÓN',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5, // Añade más espaciado entre letras
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Añade la lógica de inicio de sesión aquí
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400], // Un tono más vivo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Bordes más suaves
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                          shadowColor: Colors.black.withOpacity(0.3), // Sombra del botón
                          elevation: 5, // Efecto de elevación
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir los campos de entrada
  Widget _buildInputField(String label, String hintText, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Tamaño de fuente más grande
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), // Fondo blanco opaco
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: TextFormField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.blue[700]),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
}
