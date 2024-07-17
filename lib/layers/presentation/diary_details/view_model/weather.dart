import '../../../application/common/app_text.dart';
import '../../../application/common/custom_string_convertible.dart';

enum Weather implements CustomStringConvertible {
  cloudy,
  sunny,
  rain,
  snow,
  hot;

  @override
  String toCustomString() {
    switch (this) {
      case Weather.cloudy:
        return WeatherText.cloudy;
      case Weather.sunny:
        return WeatherText.sunny;
      case Weather.rain:
        return WeatherText.rain;
      case Weather.snow:
        return WeatherText.snow;
      case Weather.hot:
        return WeatherText.hot;
    }
  }
}
