# ☀️ 날씨 앱

이 프로젝트는 OpenWeatherMap API를 사용하여 사용자의 현재 위치에 기반한 날씨와 공기 질 정보를 조회하는 Flutter 앱이다. 이 앱은 사용자의 현재 위치를 기반으로 날씨 및 공기 질 정보를 실시간으로 가져와 화면에 표시한다. 기초 문법을 익히고, 강의 영상을 보고 실습해본 앱이다.

## 🛠️ 1. 실행 과정

### 1.1 패키지 설치
<details>
<summary>필수 패키지 설치</summary>
<div markdown="1">

앱에서 위치 정보를 가져오고 HTTP 요청을 하기 위해 **http**와 **geolocator** 패키지를 사용한다. 아래 링크를 통해 패키지를 설치할 수 있다.:

- **http 패키지**: [http](https://pub.dev/packages/http)
- **geolocator 패키지**: [geolocator](https://pub.dev/packages/geolocator)

```yaml
dependencies:
  http: ^0.14.0
  geolocator: ^9.0.1
```
</div> </details>

## 1.2 Network 클래스 정의
<details> <summary>Network 클래스</summary> <div markdown="1">
  
- Network 클래스는 두 개의 URL을 사용하여 외부 API에서 데이터를 가져오는 역할을 한다. 이 클래스는 날씨 데이터와 공기 질 데이터를 가져오는 메서드를 포함하고 있다.

```dart
class Network {
  final String url;
  final String url2;

  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      throw Exception('Failed to load air pollution data');
    }
  }
}
```
- 생성자: Network(this.url, this.url2)
  - url: 날씨 데이터를 가져오는 API의 URL
  - url2: 공기 질 데이터를 가져오는 API의 URL

- getJsonData 메서드:
  - http.get(Uri.parse(url)): 날씨 데이터 API에 GET 요청을 보낸다.
  - 응답이 성공적일 경우, JSON 문자열을 Dart 객체로 변환한다.

- getAirData 메서드:
  - http.get(Uri.parse(url2)): 공기 질 데이터 API에 GET 요청을 보낸다.
  - 응답이 성공적일 경우, JSON 문자열을 Dart 객체로 변환한다.
</div> </details>

## 1.3 Network 클래스 인스턴스 생성
<details> <summary>Network 인스턴스 생성</summary> <div markdown="1">
  
- 인스턴스 생성: Network 클래스의 인스턴스를 생성할 때 두 개의 URL을 전달한다.
  
```dart
Network network = Network(
  'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
  'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey'
);
```

</div> </details>

## 🎥 2. 실행 화면
아래는 사용자의 현재 위치를 기반으로 날씨 및 공기 질 정보를 조회하는 앱의 실행 화면이다.
<p align="center"> <img src="https://github.com/user-attachments/assets/c09f6426-15e4-410e-b4e2-78e647ffcd74" alt="Weather App Demo" width="300"> </p>
