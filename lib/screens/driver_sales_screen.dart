import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverSalesScreen extends StatefulWidget {
  @override
  _DriverSalesScreenState createState() => _DriverSalesScreenState();
}

class _DriverSalesScreenState extends State<DriverSalesScreen> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  Location location = Location();
  final TextEditingController _saleController = TextEditingController();
  final TextEditingController _productController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Verificar permisos de ubicación
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Obtener ubicación actual
    currentLocation = await location.getLocation();
    setState(() {});

    // Centrar la cámara en la ubicación actual
    if (mapController != null && currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _registerSale() {
    if (_saleController.text.isEmpty || _productController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    // Mostrar un mensaje de confirmación con los datos de la venta
    String saleDetails = 'Venta registrada: ${_productController.text} por \$${_saleController.text}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(saleDetails)),
    );

    // Limpiar los campos después de registrar la venta
    _saleController.clear();
    _productController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Ventas"),
      ),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            height: 250,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _productController,
                  decoration: InputDecoration(
                    labelText: 'Producto',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _saleController,
                  decoration: InputDecoration(
                    labelText: 'Monto de la venta (\$)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _registerSale,
                  child: Text('Registrar Venta'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
