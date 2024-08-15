import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';
import 'package:weatherapp/screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const apikey='758bcff8b4424e4b61931136cfcf2b47';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{
    Mylocation mylocation=Mylocation();
    await mylocation.getMyCurrentLocation();
    latitude3=mylocation.latitude2;
    longitude3=mylocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey');

    var weatherData = await network.getJsonData();

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,
        parseAirPolution: airData,);
    }));
  }

  // void fetchData()async{
  //   http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
  //   if(response.statusCode==200){
  //     String jsonData=response.body;
  //     var parsingData=jsonDecode(jsonData);
  //     var myJson = parsingData(jsonData)['weather'][0]['description'];
  //     print(myJson);
  //
  //     var wind=parsingData(jsonData)['wind']['speed'];
  //     print(wind);
  //
  //     var id = parsingData(jsonData)['id'];
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80,
        ),
      ),

    );
  }
}
