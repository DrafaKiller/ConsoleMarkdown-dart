import 'package:chalkdart/chalk.dart';
import 'package:console_markdown/src/colors.dart';
import 'package:marked/marked.dart';

final ConsoleMarkdownBasic = Markdown.map({
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

final ConsoleMarkdown = Markdown.map(strict: true, {
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
  '<console color|background>': (text, match) {
    final properties = match.tagProperties;

    final color = properties['color'];
    final background = properties['background'];

    if (color != null) {
      if (!chalkColors.containsKey(color)) return match.startText + match.text + match.endText;
      text = chalkColors[color]!.color(text);
    }
    
    if (background != null) {
      if (!chalkColors.containsKey(background)) return match.startText + match.text + match.endText;
      text = chalkColors[background]!.background(text);
    }

    return text;
  },
}, placeholders: {
  ... ConsoleMarkdownBasic.placeholders,

  // Dynamic Colors
  /*
  MarkdownPlaceholder.regexp(
    r'<#(?<color>[0-Fa-f]{3}(?:[0-Fa-f]{3})?)>', end: '</#>',
    (text, match) => chalk.hex(match.start.match.namedGroup('color'))(text)
  ),

  MarkdownPlaceholder.regexp(
    r'<rgb\(\s*(?<red>\d{1,3})\s*,\s*(?<green>\d{1,3})\s*,\s*(?<blue>\d{1,3})\s*\)>',
    (text, match) => chalk.hex(match.start.match.namedGroup('color'))(text)
  ),
  */
});

void main() {
  print(
    ConsoleMarkdown.apply('''
      Hello **World**!
      __Looks *pretty* easy__

      <red>test

      <console color="red" background="black">Red text</console>
    ''')
  );
}
