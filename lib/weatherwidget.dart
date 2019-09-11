import 'package:flutter/material.dart';

import 'infolocation.dart';
import 'infoweather.dart';
import 'speakdata.dart';

class WeatherWidget extends StatefulWidget {
  WeatherWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather _weather = new Weather();
  Speaker _speaker = Speaker();

  _init() async {
    if (!weatherInstance.isEmpty()) {
      _weather = weatherInstance;
    } else {
      MyLocation _myLocation = new MyLocation();
      await _myLocation.getPos();
      await _weather.fetchData(_myLocation.latitude, _myLocation.longitude);
    }
    weatherInstance = _weather;
    setState(() {
      _weather = _weather;
    });
    String text = "Xin chào bạn, bây giờ là ${DateTime.now().hour} giờ ${DateTime.now().minute} phút. Nhiệt độ ngoài trời hiện tại là: ${_weather.curently.temperature.toString()} °C. Chỉ số tia cực tím là: ${_weather.curently.uvIndex.toString()}. Dự báo thời tiền trong một giờ tới là: ${_weather.nextTime.summary.toString()}. Chúc bạn có một ngày tốt lành.";
        _speaker.speak(text);
  }

  initState() {
    _init();
    super.initState();
  }

  dispose() {
    _speaker.top();
    super.dispose();
  }

  @override
  build(context) {
    if (_weather == null) {
      return Text("Lỗi!!!");
    } else if (_weather.displayName != null &&
        _weather.curently.temperature != null &&
        _weather.curently.uvIndex != null) {
      return ListBody(
        children: <Widget>[
          Text("Vị trí: " + _weather.displayName.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text(
              "Nhiệt độ: " +
                  _weather.curently.temperature.toStringAsFixed(2) +
                  "°C",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text("Chỉ số tia cực tím: " + _weather.curently.uvIndex.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text("Dự báo trong ngày: " + _weather.daySummary.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text(""),
          Text("Dự đoán 1 giờ sau:",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left),
          Text(
              "Nhiệt độ: " +
                  _weather.nextTime.temperature.toStringAsFixed(2) +
                  "°C",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text("Chỉ số tia cực tím: " + _weather.nextTime.uvIndex.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
          Text("Dự báo: " + _weather.nextTime.summary.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left),
        ],
      );
    }
    return Text("Đang lấy dữ liệu....",
        style: TextStyle(color: Colors.white, fontSize: 20));
  }
}
