import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WebMapScreen extends StatefulWidget {
  @override
  _WebMapScreenState createState() => _WebMapScreenState();
}

class _WebMapScreenState extends State<WebMapScreen> {
  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() {
    // Registrar un id único para el contenedor HTML que contendrá el mapa
    // Evita errores en la versión actual de Flutter al verificar si `platformViewRegistry` existe
    if (const bool.fromEnvironment('dart.library.js_util', defaultValue: false)) {
      // Registra un contenedor para el mapa en Flutter Web
      ui.platformViewRegistry.registerViewFactory('map-element', (int viewId) {
        final mapContainer = html.DivElement()
          ..id = 'map'
          ..style.width = '100%'
          ..style.height = '100%';

        final script = html.ScriptElement()
          ..type = 'text/javascript'
          ..innerHtml = '''
            function initialize() {
              const mapOptions = {
                zoom: 14,
                center: { lat: -17.3915, lng: -66.1592 },
              };
              const map = new google.maps.Map(document.getElementById('map'), mapOptions);
            }
            if (typeof google !== 'undefined') {
              initialize();
            } else {
              console.error('Google Maps API no se ha cargado.');
            }
          ''';

        html.document.body!.append(script);
        return mapContainer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HtmlElementView(viewType: 'map-element'), // Mostrar el mapa en el contenedor HTML
    );
  }
}