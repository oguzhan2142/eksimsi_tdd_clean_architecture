import '../model/base_content.dart';

import '../../features/agenda/domain/entities/contents.dart';
import 'package:html/dom.dart';

/* 
  inner link - class = 'b'
  outer link - class = 'url'
  spoiler (a taglarindan bazilari spoiler linki veriyor) class = 'b'
  br
  text
 */

class ContentExtractor {
  bool _isExtractingSpoilerContent = false;

  late List<Content> _lastSpoilerContents;
  final _contents = <Content>[];
  int _index = -1;
  bool _firstSpoilerPassed = false;

  List<Content> extract(NodeList nodeList) {
    for (var node in nodeList) {
      _index++;

      if (_isNextThreeNodePartOfSpoilerContentHead(nodeList)) {
        _isExtractingSpoilerContent = true;
      }

      if (_isExtractingSpoilerContent) {
        if (_isFirstNodeAfterSpoilerHead(nodeList)) {
          _lastSpoilerContents = <Content>[];
          _contents.add(SpoilerContent(contents: _lastSpoilerContents));
          _firstSpoilerPassed = true;
        }

        if (_isLastSpoilerHeaderNode(nodeList) && _firstSpoilerPassed) {
          _isExtractingSpoilerContent = false;
        }
      }

      if (_isOneOfSpoilerHeader(nodeList)) {
        continue;
      }
      _extractCurrentNode(node);
    }

    return _contents;
  }

  void _extractCurrentNode(Node node) {
    if (node.nodeType == Node.TEXT_NODE && node.text != null) {
      _extractTextContent(node);
    } else if (node.nodeType == Node.ELEMENT_NODE) {
      final elementNode = node as Element;
      final className = elementNode.attributes['class'] ?? '';
      if (className == 'url') {
        _extractOuterLinkContent(node);
      } else if (className == 'b') {
        _extractInnerLinkContent(node);
      } else if (elementNode.localName == 'br') {
        _extractBrContent(elementNode);
      }
    }
  }

  void _extractBrContent(Element elementNode) {
    _addModelList(BrContent());
  }

  void _extractTextContent(Node node) {
    if (node.text == null) return;

    final model = TextContent(text: node.text!.trim());

    _addModelList(model);
  }

  void _extractOuterLinkContent(Element node) {
    late final String? href;
    if (node.attributes['href'] != null) {
      href = node.attributes['href'];

      final model = OuterLinkContent(href: href!, text: node.text.trim());

      _addModelList(model);
    }
  }

  _extractInnerLinkContent(Element node) {
    late final String href;
    if (node.attributes['href'] == null) {
      return null;
    }

    href = node.attributes['href']!;

    final model = InnerLinkContent(href: href, text: node.text.trim());
    _addModelList(model);
  }

  void _addModelList(Content model) {
    if (_isExtractingSpoilerContent) {
      _lastSpoilerContents.add(model);
    } else {
      _contents.add(model);
    }
  }

  bool _isNextThreeNodePartOfSpoilerContentHead(NodeList list) {
    if (_index + 3 > list.length) {
      return false;
    }
    final firstOk = list[_index].text!.trim() == '---';
    final secondOk = list[_index + 1].text!.trim() == 'spoiler';
    final thirdOk = list[_index + 2].text!.trim() == '---';

    return firstOk && secondOk && thirdOk;
  }

  bool _isFirstNodeAfterSpoilerHead(NodeList list) {
    if (list.length < 4) return false;

    if (_index < 3) return false;

    final firstOk = list[_index - 3].text!.trim() == '---';
    final secondOk = list[_index - 2].text!.trim() == 'spoiler';
    final thirdOk = list[_index - 1].text!.trim() == '---';

    return firstOk && secondOk && thirdOk;
  }

  bool _isLastSpoilerHeaderNode(NodeList list) {
    if (list.length < 3) {
      return false;
    }

    if (_index < 3) return false;

    final firstOk = list[_index - 2].text!.trim() == '---';
    final secondOk = list[_index - 1].text!.trim() == 'spoiler';
    final thirdOk = list[_index].text!.trim() == '---';

    return firstOk && secondOk && thirdOk;
  }

  bool _isOneOfSpoilerHeader(NodeList nodeList) {
    if (nodeList.isEmpty) return false;

    final nodeText = nodeList[_index].text!.trim();
    if (nodeText == 'spoiler' || nodeText == '---') {
      return true;
    }

    return false;
  }
}
