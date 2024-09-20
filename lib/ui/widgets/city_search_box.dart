import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart'; // Import your WeatherNotifier

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  CitySearchBoxState createState() => CitySearchBoxState();
}

class CitySearchBoxState extends State<CitySearchBox> {
  static const _radius = 30.0;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final city = Provider.of<WeatherNotifier>(context, listen: false).city;
    _searchController = TextEditingController(text: city);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherNotifier = Provider.of<WeatherNotifier>(context, listen: false);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: _radius * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Enter City Name...',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      bottomLeft: Radius.circular(_radius),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  weatherNotifier.updateCity(value); // Update city when submitting
                },
              ),
            ),
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                weatherNotifier.updateCity(_searchController.text); // Search on button press
              },
              child: Container(
                // alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_radius),
                    bottomRight: Radius.circular(_radius),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                child: Text(
                  'Search',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
