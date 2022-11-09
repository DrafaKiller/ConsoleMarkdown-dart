import 'package:chalkdart/chalk.dart';
import 'package:console_markdown/src/schema.dart';
import 'package:marked/src/node.dart';

final Map<String, ChalkColorBundle> chalkColors = {
  'black': ChalkColorBundle(chalk.black, chalk.bgBlack),
  'red': ChalkColorBundle(chalk.red, chalk.bgRed),
  'green': ChalkColorBundle(chalk.green, chalk.bgGreen),
  'yellow': ChalkColorBundle(chalk.yellow, chalk.bgYellow),
  'blue': ChalkColorBundle(chalk.blue, chalk.bgBlue),
  'magenta': ChalkColorBundle(chalk.magenta, chalk.bgMagenta),
  'cyan': ChalkColorBundle(chalk.cyan, chalk.bgCyan),
  'white': ChalkColorBundle(chalk.white, chalk.bgWhite),
  'gray': ChalkColorBundle(chalk.gray, chalk.bgGray),
};

/* -= Color Methods =- */

String Function(String text, MarkdownNode node) colorTagReplace([
  Chalk? color,
  Chalk? backgroundColor,
]) {
  return (text, node) {
    final properties = node.tagProperties;

    if (properties['background'] != null) {
      return backgroundColor != null
        ? backgroundColor(text)
        : text;
    }
    
    return color != null
      ? color(text)
      : text;
  };
}

String applyDynamicColors(String text, String color, MarkdownNode node, { bool isBackground = false }) {
  if (chalkColors.containsKey(color)) {
    return isBackground
      ? chalkColors[color]!.background(text)
      : chalkColors[color]!.color(text);
  }

  final hexMatch = _hexColorPattern.firstMatch(color);
  if (hexMatch != null) {
    return isBackground
      ? chalk.bgHex(hexMatch.namedGroup('color'))(text)
      : chalk.hex(hexMatch.namedGroup('color'))(text);
  }

  final rgbMatch = _rgbColorPattern.firstMatch(color);
  if (rgbMatch != null) {
      final red = int.parse(rgbMatch.namedGroup('red')!);
      final green = int.parse(rgbMatch.namedGroup('green')!);
      final blue = int.parse(rgbMatch.namedGroup('blue')!);
    return isBackground
      ? chalk.bgRgb(red, green, blue)(text)
      : chalk.rgb(red, green, blue)(text);
  }

  if (node.strict) node.start.throwMissingToken();
  return text;
}

final _hexColorPattern = RegExp(r'^#(?<color>[0-F]{3}(?:[0-F]{3})?)$', caseSensitive: false);
final _rgbColorPattern = RegExp(r'^rgb\(\s*(?<red>\d{1,3}),\s*(?<green>\d{1,3})\s*,\s*(?<blue>\d{1,3})\s*\)$', caseSensitive: false);
