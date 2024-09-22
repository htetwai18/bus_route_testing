import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BusRoute {
  final List<Offset> points;
  final Color color;

  BusRoute({required this.points, required this.color});
}

class BusStop {
  final Offset position;
  final String label;

  BusStop({required this.position, required this.label});
}

class DynamicBusRoutePainter extends CustomPainter {
  final List<BusRoute> routes;
  final List<BusStop> busStops;

  DynamicBusRoutePainter({required this.routes, required this.busStops});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw routes (lines)
    for (var route in routes) {
      final paint = Paint()
        ..color = route.color
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;

      final path = Path();
      for (int i = 0; i < route.points.length; i++) {
        if (i == 0) {
          path.moveTo(route.points[i].dx, route.points[i].dy);
        } else {
          path.lineTo(route.points[i].dx, route.points[i].dy);
        }
      }

      canvas.drawPath(path, paint);
    }

    // Draw bus stops (circles)
    final stopPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final stopBorderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var stop in busStops) {
      _drawBusStop(canvas, stopPaint, stopBorderPaint, stop.position);
      _drawStopLabel(canvas, stop.label, stop.position);
    }
  }

  void _drawBusStop(
      Canvas canvas, Paint stopPaint, Paint stopBorderPaint, Offset center) {
    canvas.drawCircle(center, 10, stopPaint); // Fill
    canvas.drawCircle(center, 10, stopBorderPaint); // Border
  }

  void _drawStopLabel(Canvas canvas, String label, Offset position) {
    final TextSpan span = TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 12),
      text: label,
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
        canvas,
        position +
            const Offset(15, -10)); // Adjust label position relative to stop
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated dynamically
  }
}

class DynamicBusRouteMap extends StatefulWidget {
  const DynamicBusRouteMap({super.key});

  @override
  _DynamicBusRouteMapState createState() => _DynamicBusRouteMapState();
}

class _DynamicBusRouteMapState extends State<DynamicBusRouteMap> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;

  // Zoom in function
  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + 0.2).clamp(1.0, 4.0); // Max scale of 4.0
      _transformationController.value = Matrix4.identity()
        ..scale(_currentScale);
    });
  }

  // Zoom out function
  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - 0.2).clamp(1.0, 4.0); // Min scale of 1.0
      _transformationController.value = Matrix4.identity()
        ..scale(_currentScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define bus routes (more lines)
    final routes = [
      BusRoute(
        points: [
          const Offset(50, 50),
          const Offset(200, 50),
          const Offset(250, 100),
          const Offset(250, 250)
        ],
        color: Colors.blue,
      ),
      BusRoute(
        points: [
          const Offset(100, 250),
          const Offset(100, 150),
          const Offset(200, 100),
          const Offset(300, 100)
        ],
        color: Colors.green,
      ),
      BusRoute(
        points: [
          const Offset(300, 50),
          const Offset(350, 150),
          const Offset(300, 250),
          const Offset(150, 250)
        ],
        color: Colors.red,
      ),
    ];

    // Define bus stops
    final busStops = [
      BusStop(position: const Offset(50, 50), label: "Stop A"),
      BusStop(position: const Offset(200, 50), label: "Stop B"),
      BusStop(position: const Offset(250, 100), label: "Interchange 1"),
      BusStop(position: const Offset(250, 250), label: "Stop C"),
      BusStop(position: const Offset(100, 250), label: "Stop D"),
      BusStop(position: const Offset(300, 100), label: "Stop E"),
      BusStop(position: const Offset(300, 50), label: "Stop F"),
      BusStop(position: const Offset(350, 150), label: "Interchange 2"),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // InteractiveViewer allows panning and zooming
          InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin:
                const EdgeInsets.all(100), // Allow panning beyond the canvas
            minScale: 1.0,
            maxScale: 4.0, // Maximum zoom level
            child: CustomPaint(
              size: const Size(1000, 1000), // Large canvas size
              painter:
                  DynamicBusRoutePainter(routes: routes, busStops: busStops),
            ),
          ),
          // Zoom controls on the right side
          Positioned(
            right: 10,
            top: 50,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  mini: true,
                  child: Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  mini: true,
                  child: Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
