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
                      // Even bigger centered logo with adjusted padding
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,  // Reduced vertical padding
                          horizontal: 15.0,  // Slightly reduced horizontal padding
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 100,  // Increased from 80 to 100
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 15),  // Slightly reduced spacing
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
                            _buildButton('SEGUIR VEHÍCULO'),
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
                            _buildButton('CERRAR SESIÓN', isLogout: true),
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
                              // Add close functionality
                            },
                            child: Image.asset(
                              'assets/cerrar.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
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

  Widget _buildButton(String text, {bool isLogout = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Add button functionality
        },
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

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 2,
      color: Colors.black,
    );
  }
}