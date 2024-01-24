import 'package:flutter/material.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:pie_chart/pie_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({
    super.key,
    required this.genreMap,
    required this.artistMap,
    required this.friendsMap,
  });

  final Map<String, double> genreMap;
  final Map<String, double> artistMap;
  final Map<String, double> friendsMap;

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool _percs1 = true;
  bool _percs2 = false;
  bool _percs3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your statistics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManager.lighterSwatch.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _title('Genres'),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (context) {
                          if (widget.genreMap.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ElevatedIcon(
                                    iconData: Icons.lyrics_outlined,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'No data here!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return PieChart(
                              dataMap: widget.genreMap,
                              centerText: 'Genres',
                              chartLegendSpacing: 16,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 1.5,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: _percs1,
                              ),
                              legendOptions: const LegendOptions(
                                  // legendPosition: LegendPosition.bottom,
                                  // showLegendsInRow: false,
                                  ),
                            );
                          }
                        },
                      ),
                      if (widget.genreMap.isNotEmpty)
                        Row(
                          children: [
                            Switch(
                              value: _percs1,
                              onChanged: (bool value) {
                                setState(() {
                                  _percs1 = value;
                                });
                              },
                            ),
                            const Text(
                              'Percentages',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManager.lighterSwatch.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _title('Most liked artists'),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (context) {
                          if (widget.genreMap.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ElevatedIcon(
                                    iconData: Icons.lyrics_outlined,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'No data here!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return PieChart(
                              dataMap: widget.artistMap,
                              centerText: 'Artists',
                              chartLegendSpacing: 16,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 1.5,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: _percs2,
                              ),
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.bottom,
                                showLegendsInRow: true,
                              ),
                            );
                          }
                        },
                      ),
                      if (widget.genreMap.isNotEmpty)
                        Row(
                          children: [
                            Switch(
                              value: _percs2,
                              onChanged: (bool value) {
                                setState(() {
                                  _percs2 = value;
                                });
                              },
                            ),
                            const Text(
                              'Percentages',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorManager.lighterSwatch.shade300,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      _title('Shared likes with friends'),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (context) {
                          if (widget.genreMap.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ElevatedIcon(
                                    iconData: Icons.lyrics_outlined,
                                    size: 50,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    'No data here!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return PieChart(
                              dataMap: widget.friendsMap,
                              centerText: 'Friends',
                              chartLegendSpacing: 16,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 1.5,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: _percs3,
                              ),
                              legendOptions: const LegendOptions(
                                  // legendPosition: LegendPosition.bottom,
                                  // showLegendsInRow: false,
                                  ),
                            );
                          }
                        },
                      ),
                      if (widget.genreMap.isNotEmpty)
                        Row(
                          children: [
                            Switch(
                              value: _percs3,
                              onChanged: (bool value) {
                                setState(() {
                                  _percs3 = value;
                                });
                              },
                            ),
                            const Text(
                              'Percentages',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
