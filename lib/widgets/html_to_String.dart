import 'package:html/parser.dart';


  String parseHtmlString(String htmlString) {
    var document = parse(htmlString.replaceAll('<p>', "\n\n"));

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

