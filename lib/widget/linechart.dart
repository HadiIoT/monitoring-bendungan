import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class chart extends StatelessWidget {
  const chart({
    Key? key,
    required this.bodyheight,
    required this.mediaqueryWidth,
    required this.datasensor,
  }) : super(key: key);

  final double bodyheight;
  final double mediaqueryWidth;
  final List<double> datasensor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bodyheight * 0.4,
      width: mediaqueryWidth * 0.8,
      child: Sparkline(
        data: datasensor,
        enableGridLines: false,

        gridLineLabelPrecision: 2,

        lineWidth: 3.0,
        pointSize: 13.0,
        pointsMode: PointsMode.last,
        pointColor: Colors.blue,
        useCubicSmoothing: true,
        cubicSmoothingFactor: 0.2,

        lineColor: Colors.blue,
        kLine: [
          'max',
          'min',
          'first',
          'last',
        ],

        fillMode: FillMode.below,
        fillColor: Color(0xFFBBCEF2),
        fillGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF245BDD),
            Color(0xFF97A8D0),
          ],
        ),
      ),
    );
  }
}
