import 'package:flutter/material.dart';

class MainInterface extends StatelessWidget {
  const MainInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Logo and buttons
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Centered logo with padding adjustments
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Buttons Container
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Botón "SEGUIR VEHÍCULO" con navegación al mapa
                            _buildButton(
                              'SEGUIR VEHÍCULO',
                              onTap: () {
                                Navigator.pushNamed(context, '/map');
                              },
                            ),
                            _buildDivider(),
                            _buildButton('REGISTRO DE\nINVENTARIO VEHICULAR'),
                            _buildDivider(),
                            _buildButton('PLANIFICAR RUTAS'),
                            _buildDivider(),
                            _buildButton('MENSAJES Y ALERTAS'),
                            _buildDivider(),
                            _buildButton('VER REGISTRO DE VENTAS'),
                            _buildDivider(),
                            _buildButton('INFORME'),
                            _buildDivider(),
                            _buildButton(
                              'CERRAR SESIÓN',
                              isLogout: true,
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right side - Large content container
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple.shade200,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Stack(
                      children: [
                        // Close button
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Vuelve a la pantalla anterior
                            },
                            child: Image.asset(
                              'assets/cerrar.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        // Aquí podrías agregar contenido adicional para la interfaz principal
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir los botones
  Widget _buildButton(String text, {bool isLogout = false, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, // Funcionalidad de navegación del botón
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          color: isLogout ? const Color(0xFF87CEEB) : Colors.transparent,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isLogout ? Colors.white : Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir divisores entre botones
  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 2,
      color: Colors.black,
    );
  }
}