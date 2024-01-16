import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String apiKey = 'f684693b5b57590817809f45468eb9bc';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  var latitude;
  var longitude;
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // await keyword stands for "wait until this process is complete"
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print(location.latitude);
    print(location.longitude);

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.red.shade900,
          size: 100,
        ),
      ),
    );
  }
}
// var longitude = jsonDecode(data)['coord']['lon'];
// var weather = jsonDecode(data)['weather'][0]['main'];
// var temp = jsonDecode(data)['main']['temp'];
// var city = jsonDecode(data)['name'];
// var id = jsonDecode(data)['weather'][0]['id'];
