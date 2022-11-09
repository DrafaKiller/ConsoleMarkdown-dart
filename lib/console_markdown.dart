library console_markdown;

import 'package:console_markdown/src/markdown.dart';

export 'src/markdown.dart';

extension ConsoleMarkdownString on String {
  String toConsole({ bool? strict }) => ConsoleMarkdown.apply(this, strict: strict);
  String toStrictConsole() => toConsole(strict: true);
}