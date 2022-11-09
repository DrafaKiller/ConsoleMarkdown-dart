import 'package:chalkdart/chalk.dart';
import 'package:console_markdown/src/colors.dart';
import 'package:marked/marked.dart';

final ConsoleMarkdownBasicSymbols = Markdown.map({
  // Formatting
  '[**]': (text, match) => chalk.bold(text),
  '[*]': (text, match) => chalk.italic(text),
  '[___]': (text, match) => chalk.doubleunderline(text),
  '[__]': (text, match) => chalk.underline(text),
  '[~~]': (text, match) => chalk.strikethrough(text),
  
  '[!!!]': (text, match) => chalk.rapidblink(text),
  '[!!]': (text, match) => chalk.blink(text),
  '[`]': (text, match) => chalk.dim(text),
  '[||]': (text, match) => chalk.hidden(text),
  '[^^]': (text, match) => chalk.inverse(text),
  '[^]': (text, match) => chalk.superscript(text),
  '[~]': (text, match) => chalk.subscript(text),
});

final ConsoleMarkdownBasic = Markdown.map({
  '<console color|background | reset|blink|rapid|bold|dim|italic|underline|double-underline|overline|inverse|hidden|superscript|subscript|strikethrough>': (text, match) {
    final properties = match.tagProperties;

    final color = properties['color'];
    final background = properties['background'];

    if (color != null) text = applyDynamicColors(text, color, match);
    if (background != null) text = applyDynamicColors(text, background, match, isBackground: true);

    if (properties['reset'] != null) text = chalk.reset(text);
    if (properties['blink'] != null) text = chalk.blink(text);
    if (properties['rapid-blink'] != null) text = chalk.rapidblink(text);
    if (properties['bold'] != null) text = chalk.bold(text);
    if (properties['dim'] != null) text = chalk.dim(text);
    if (properties['italic'] != null) text = chalk.italic(text);
    if (properties['underline'] != null) text = chalk.underline(text);
    if (properties['double-underline'] != null) text = chalk.doubleunderline(text);
    if (properties['overline'] != null) text = chalk.overline(text);
    if (properties['inverse'] != null) text = chalk.inverse(text);
    if (properties['hidden'] != null) text = chalk.hidden(text);
    if (properties['superscript'] != null) text = chalk.superscript(text);
    if (properties['subscript'] != null) text = chalk.subscript(text);
    if (properties['strikethrough'] != null) text = chalk.strikethrough(text);

    return text;
  },
});

final ConsoleMarkdown = Markdown.map({
  // Tags
  'basic: <reset>': (text, match) => chalk.reset(''),
  '<blink>': (text, match) => chalk.blink(text),
  '<rapid-blink>': (text, match) => chalk.rapidblink(text),
  '<bold>': (text, match) => chalk.bold(text),
  '<dim>': (text, match) => chalk.dim(text),
  '<italic>': (text, match) => chalk.italic(text),
  '<underline>': (text, match) => chalk.underline(text),
  '<double-underline>': (text, match) => chalk.doubleunderline(text),
  '<overline>': (text, match) => chalk.overline(text),
  '<inverse>': (text, match) => chalk.inverse(text),
  '<hidden>': (text, match) => chalk.hidden(text),
  '<superscript>': (text, match) => chalk.superscript(text),
  '<subscript>': (text, match) => chalk.subscript(text),
  '<strikethrough>': (text, match) => chalk.strikethrough(text),

  // Colors
  for (final color in chalkColors.entries)
    '<${color.key} background>': colorTagReplace(color.value.color, color.value.background),

  // Dynamic Colors
  r'<#(?<color>[0-F]{3}(?:[0-F]{3})?) background>': (text, match) {
    final properties = match.tagProperties;
    final color = match.start.match.namedGroup('color');

    if (color == null) {
      if (match.strict) match.start.throwMissingToken();
      return text;
    }

    if (properties['background'] != null)  return applyDynamicColors(text, '#$color', match, isBackground: true);
    return applyDynamicColors(text, '#$color', match);
  },

  r'<rgb\(\s*(?<color>[0-9]{1,3}\s*,\s*[0-9]{1,3}\s*,\s*[0-9]{1,3})\s*\) background>': (text, match) {
    final properties = match.tagProperties;
    final color = match.start.match.namedGroup('color');

    if (color == null) {
      if (match.strict) match.start.throwMissingToken();
      return text;
    }

    if (properties['background'] != null)  return applyDynamicColors(text, 'rgb($color)', match, isBackground: true);
    return applyDynamicColors(text, 'rgb($color)', match);
  },
}, placeholders: {
  ... ConsoleMarkdownBasicSymbols.placeholders,
  ... ConsoleMarkdownBasic.placeholders,
});
