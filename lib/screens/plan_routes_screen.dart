import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanRoutesScreen extends StatefulWidget {
  @override
  _PlanRoutesScreenState createState() => _PlanRoutesScreenState();
}

class _PlanRoutesScreenState extends State<PlanRoutesScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = {};
  List<LatLng> _routePoints = [];
  LatLng? _origin;
  LatLng? _destination;
  String? _apiKey = "TU_API_KEY_DE_GOOGLE_MAPS";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planificar Ruta"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _registerRoute,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-17.3915, -66.1592), // Coordenadas iniciales
              zoom: 13,
            ),
            markers: _markers,
            polylines: {
              if (_routePoints.isNotEmpty)
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.blue,
                  width: 5,
                  points: _routePoints,
                ),
            },
            onTap: _addMarker,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
          ),
          if (_origin != null && _destination != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _traceRoute,
                child: Text("Trazar Ruta"),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _addMarker(LatLng position) async {
    setState(() {
      if (_origin == null) {
        _origin = position;
        _markers.add(
          Marker(markerId: MarkerId('origin'), position: _origin!),
        );
      } else if (_destination == null) {
        _destination = position;
        _markers.add(
          Marker(markerId: MarkerId('destination'), position: _destination!),
        );
      }
    });
  }

  Future<void> _traceRoute() async {
    if (_origin == null || _destination == null || _apiKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes seleccionar origen y destino.")),
      );
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin!.latitude},${_origin!.longitude}&destination=${_destination!.latitude},${_destination!.longitude}&key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final points = data['routes'][0]['overview_polyline']['points'];
      final polyline = _decodePolyline(points);

      setState(() {
        _routePoints = polyline;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al obtener la ruta.")),
      );
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polyline;
  }

  void _registerRoute() {
    if (_origin == null || _destination == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se puede registrar una ruta incompleta.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Ruta registrada exitosamente.")),
    );

    // Aquí puedes agregar la lógica para guardar la ruta en la base de datos o enviarla al backend
  }
}
