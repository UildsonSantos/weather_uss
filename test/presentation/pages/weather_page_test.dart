import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_uss/domain/entities/weather.dart';
import 'package:weather_uss/presentation/bloc/weather_bloc.dart';
import 'package:weather_uss/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  testWidgets('text field shold trigger state to change from empty to loading',
      (widgetTester) async {
    // arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    var textField = find.byType(TextField);

    expect(textField, findsOneWidget);

    await widgetTester.enterText(textField, 'New York');
    await widgetTester.pump();
    expect(find.text('New York'), findsOneWidget);
  });

  testWidgets('should show progress indicator when state is loading',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    //act
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    //assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
