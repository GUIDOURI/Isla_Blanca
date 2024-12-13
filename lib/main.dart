import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/menu_screen.dart'; // Menú principal
import 'screens/web_map_screen.dart'; // Pantalla de mapa
import 'screens/inventory_screen.dart'; // Pantalla de inventario
import 'screens/messages_alerts_screen.dart'; // Pantalla de mensajes y alertas
import 'screens/driver_menu_screen.dart'; // Menú para el chofer
import 'screens/sales_screen.dart'; // Pantalla de ventas
import 'screens/route_screen.dart'; // Pantalla del camino a seguir
import 'screens/chat_screen.dart'; // Pantalla del chat
import 'screens/informe_screen.dart'; // Pantalla del informe
import 'screens/plan_routes_screen.dart'; // Pantalla de planificación de rutas

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isla Blanca App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/menu': (context) => const MainInterface(),
        '/map': (context) => WebMapScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/messages_alerts': (context) => const MessagesAlertsScreen(),
        '/driverMenu': (context) => const DriverMenuScreen(),
        '/sales': (context) => SalesScreen(),
        '/route': (context) => RouteScreen(),
        '/chat': (context) => ChatScreen(),
        '/informe': (context) => InformeScreen(),
        '/planRoutes': (context) => PlanRoutesScreen(), // Ruta para planificación de rutas
      },
    );
  }
}
