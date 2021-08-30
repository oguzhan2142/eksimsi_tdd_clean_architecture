import 'package:eksimsi_tdd_clean_architecture/core/model/base_content.dart';
import 'package:eksimsi_tdd_clean_architecture/features/agenda/data/models/agenda_content_model.dart';
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

  var _lastSpoilerContents;
  final contents = <Content>[];
  int _index = -1;

  void extract(NodeList nodeList) {
    for (var node in nodeList) {
      _index++;

      if (isNextThreeNodePartOfSpoilerContentHead(nodeList)) {
        _isExtractingSpoilerContent = true;
      }

      if (_isExtractingSpoilerContent) {
        if (_isFirstNodeAfterSpoilerHead(nodeList)) {
          _lastSpoilerContents = <Content>[];
          contents.add(SpoilerContent(contents: _lastSpoilerContents));
        }

        if (isLastSpoilerHeaderNode(nodeList)) {
          _isExtractingSpoilerContent = false;
        }
      }

      if (isOneOfSpoilerHeader(nodeList)) {
        continue;
      }
      _extractCurrentNode(node);
    }
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

    final model = AgendaTextContentModel(text: node.text!.trim());

    _addModelList(model);
  }

  void _extractOuterLinkContent(Element node) {
    late final href;
    if (node.attributes['href'] == null) {
      return null;
    }

    href = node.attributes['href'];


    final model = OuterLinkContent(href: href, text: node.text.trim());

    _addModelList(model);
  }

  _extractInnerLinkContent(Element node) {
    late final href;
    if (node.attributes['href'] == null) {
      return null;
    }

    href = node.attributes['href'];

    final model = InnerLinkContent(href: href, text: node.text.trim());
    _addModelList(model);
  }

  void _addModelList(Content model) {
    if (_isExtractingSpoilerContent) {
      _lastSpoilerContents.add(model);
    } else {
      contents.add(model);
    }
  }

  bool isNextThreeNodePartOfSpoilerContentHead(NodeList list) {
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

  bool isLastSpoilerHeaderNode(NodeList list) {
    if (list.length < 3) {
      return false;
    }

    if (_index < 3) return false;

    final firstOk = list[_index - 2].text!.trim() == '---';
    final secondOk = list[_index - 1].text!.trim() == 'spoiler';
    final thirdOk = list[_index].text!.trim() == '---';

    return firstOk && secondOk && thirdOk;
  }

  bool isOneOfSpoilerHeader(NodeList nodeList) {
    if (nodeList.isEmpty) return false;

    final nodeText = nodeList[_index].text!.trim();
    if (nodeText == 'spoiler' || nodeText == '---') {
      return true;
    }

    return false;
  }

  
}
