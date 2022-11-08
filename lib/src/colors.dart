import 'package:chalkdart/chalk.dart';
import 'package:console_markdown/src/schema.dart';
import 'package:marked/src/node.dart';

String Function(String text, MarkdownNode node) colorTagReplace([
  Chalk? color,
  Chalk? backgroundColor,
]) {
  return (text, node) {
    final properties = node.tagProperties;

    if (properties['background'] != null)
      return backgroundColor != null
        ? backgroundColor(text)
        : text;
    return color != null
      ? color(text)
      : text;
  };
}

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