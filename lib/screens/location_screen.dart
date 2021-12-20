import 'package:flutter/material.dart';
import 'package:weather_flutter/screens/city_screen.dart';
import 'package:weather_flutter/services/weather.dart';
import 'package:weather_flutter/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherLocation});
  final weatherLocation;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  late int temp;
  late String tempIcon;
  late String idIcon;
  late String city;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.weatherLocation);
  }

  void updateUI(dynamic weatherUpdate) {
    setState(() {
      if (weatherUpdate == null) {
        temp = 0;
        idIcon = 'Error';
        city = 'Unavailable';
        tempIcon = 'Unable to get weather data';
        return;
      }
      double temper = weatherUpdate['main']['temp'];
      temp = temper.toInt();
      int id = weatherUpdate['weather'][0]['id'];
      idIcon = weatherModel.getWeatherIcon(id);

      city = weatherUpdate['name'];
      tempIcon = weatherModel.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherUpdate =
                          await weatherModel.getLocationWeather();
                      updateUI(weatherUpdate);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typendName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typendName != null) {
                        var weatherUpdate =
                            await weatherModel.getCityWeather(typendName);
                        updateUI(weatherUpdate);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      idIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '${tempIcon} in ${city}',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
