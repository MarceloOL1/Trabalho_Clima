import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'models/weather_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: "Enter City Name"),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<WeatherProvider>(context, listen: false)
                    .getWeather(_cityController.text);
              },
              child: Text("Get Weather"),
            ),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.weather != null) {
                  return Column(
                    children: [
                      Text("City: ${provider.weather!.cityName}"),
                      Text(
                          "Temperature: ${provider.weather!.temperature.toStringAsFixed(1)}°C"),
                      Text("Description: ${provider.weather!.description}"),
                    ],
                  );
                } else {
                  return Text("No data available");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
