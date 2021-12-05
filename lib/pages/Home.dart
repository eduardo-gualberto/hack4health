import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hack4health/computasus_db.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //cores do grafico
  List<Color> gradientColors = [
    const Color(0xff00ff00),
    const Color(0xff02d39a),
  ];
  List<FlSpot> s = [];

  Future<List<FlSpot>> getHistoricoFreq(int id) async {
      List<Medicao> at = await medicao();
      double c = 0;
      for (var m in at){
        if (m.id_paciente == id){
          s.add(FlSpot(c,m.freq.toDouble()/*double.parse(m.horario)*/));
          c += 1;
        }
      }
      print(s);
      return s;
    }

  @override
  void initState() {
    super.initState();
    getHistoricoFreq(super.widget.id).then((value){
      setState(() {
        s = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          height: 20,
        ),
        Text(
          "Frequência cardíaca (bpm)"
        ),
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xfffafafa)
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                frequenciaData(), //grafico eh processado
              ),
            ),
          ),
        ),
        /*AspectRatio(
          aspectRatio: 4.60,
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xfffafafa)
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                pesoData(), //grafico eh processado
              ),
            ),
          ),
        ),*/
      ],
      ),
    ),
    );
  }

  LineChartData frequenciaData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff737373),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff737373),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'QUA';
              case 2:
                return 'QUI';
              case 4:
                return 'SEX';
              case 6:
                return 'SAB';
              case 8:
                return 'DOM';
              case 10:
                return 'SEG';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff737373),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 20:
                return '20';
              case 60:
                return '60';
              case 100:
                return '100';
              case 140:
                return '140';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff737373), width: 1)),
      minX: 0,
      maxX: s.length.toDouble()-1,
      minY: 0,
      maxY: 150,
      lineBarsData: [
        LineChartBarData(
          spots: s,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
/*
  LineChartData pesoData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff737373),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff737373),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'QUA';
              case 2:
                return 'QUI';
              case 4:
                return 'SEX';
              case 6:
                return 'SAB';
              case 8:
                return 'DOM';
              case 10:
                return 'SEG';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff737373),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 60:
                return '60';
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff737373), width: 1)),
      minX: 0,
      maxX: s.length.toDouble()-1,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: s,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }*/
}