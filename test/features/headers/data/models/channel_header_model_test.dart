import 'dart:collection';

import 'package:eksimsi_tdd_clean_architecture/core/error/exception.dart';
import 'package:eksimsi_tdd_clean_architecture/features/headers/data/models/channel_header_model.dart';


import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'channel_header_model_test.mocks.dart';



@GenerateMocks([Element])
void main() {
  final expected = ChannelHeaderModel(
    href: '/basliklar/kanal/haber',
    title: '#haber',
    subTitle: 'yurtta ve dünyada olan biten',
  );

  late MockElement baseElement;

  setUp(() {
    baseElement = MockElement();
  });

  test('should return [ModelConversionException] when there is no a tag', () {
    // arrange

    when(baseElement.getElementsByClassName('a')).thenThrow(Exception());

    // assert
    expect(
      () => ChannelHeaderModel.fromLi(element: baseElement),
      throwsA(isA<ModelConversionException>()),
    );
  });

  test(
      'should return empty string when couldnt find any attributes from element',
      () {
    // arrange
    final MockElement aElement = MockElement();

    when(baseElement.getElementsByClassName('a')).thenReturn([aElement]);
    when(aElement.text).thenReturn('');

    when(aElement.attributes).thenReturn(
      LinkedHashMap.from({}),
    );

    // act
    final model = ChannelHeaderModel.fromLi(element: baseElement);

    // assert
    expect(model.href, '');
    expect(model.title, '');
  });

  test('should return valid [ChannelHeader] from fromLi method', () {
    // arrange

    final MockElement aElement = MockElement();

    when(baseElement.getElementsByClassName('a')).thenReturn([aElement]);

    
    when(aElement.attributes).thenReturn(LinkedHashMap.from({
      'href': '/basliklar/kanal/haber',
      'title': 'yurtta ve dünyada olan biten',
    }),);
    
    when(aElement.text).thenReturn('#haber');

    // act
    final model = ChannelHeaderModel.fromLi(element: baseElement);

    // assert
    expect(model, expected);
  });
}
