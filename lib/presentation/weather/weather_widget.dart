import '../../exports.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status.isInProgress) {
          return shimmerColors(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        IconsaxOutline.location,
                        color: Colors.white,
                      ),
                      4.width,
                      Text(
                        "Searching",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    "Today, ",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "0",
                        style: TextStyle(
                          fontSize: 100,
                        ),
                      ),
                      Text(
                        "°C",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                  8.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.white),
                          color: Colors.white.withValues(alpha: .3)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            IconsaxOutline.wind,
                            color: Colors.white,
                          ),
                          8.width,
                          Text(
                            "0 km/h",
                            style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          var data = state.weather;
          return data != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      IconsaxOutline.location,
                      color: Colors.white,
                    ),
                    4.width,
                    FutureBuilder(
                            future: _fetchData(data.latitude, data.longitude),
                            builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                            child: Text(
                              snapshot.requireData,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          );
                        } else {
                          return shimmerColors(
                              child: Text(
                                "Searching",
                              ));
                        }
                      },
                    ),
                  ],
                ),
                8.height,
                Text(
                  "Today, ${data.current_weather.time.formattedDate}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.current_weather.temperature.round()}",
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient,
                      ),
                    ),
                    Text(
                      data.current_weather_units.temperature,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                ),
                8.height,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.white),
                        color: Colors.white.withValues(alpha: .3)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconsaxOutline.wind,
                          color: Colors.white,
                        ),
                        8.width,
                        Text(
                          "${data.current_weather.windspeed} ${data.current_weather_units.windspeed}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
              : SizedBox();
        }
      },
    );
  }
}

Future<String> _fetchData(double latitude, double longitude) async {
  var place = await getPlaceMarkFromLatLng(latitude, longitude);
  return place;
}