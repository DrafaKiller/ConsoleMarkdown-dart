import 'package:chalkdart/chalk.dart';
import 'package:console_markdown/src/colors.dart';
import 'package:marked/marked.dart';

/// ### Markdown Cheatsheet - Symbols
/// 
/// | Symbol | Property         | Example        | Result          |
/// | ------ | ---------------- | -------------- | --------------- |
/// | `**`   | bold             | `**text**`     | **text**        |
/// | `*`    | italic           | `*text*`       | *text*          |
/// | `__`   | underline        | `__text__`     | <u>text</u>     |
/// | `~~`   | strikethrough    | `~~text~~`     | ~~text~~        |
/// | `^`    | superscript      | `^text^`       | <sup>text</sup> |
/// | `~`    | subscript        | `~text~`       | <sub>text</sub> |
/// | `___`  | double-underline | `___text___`   |                 |
/// | `!!`   | blink            | `!!text!!`     |                 |
/// | `!!!`  | rapid-blink      | `!!!text!!!`   |                 |
/// | `\|\|` | hidden           | `\|\|text\|\|` |                 |
/// | `^^`   | inverse          | `^^text^^`     |                 |
/// | \`     | dim              | \``text`\`     |                 |
// ignore: non_constant_identifier_names
final ConsoleMarkdownSymbols = Markdown.map({
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

/// ### Markdown Cheatsheet - Basic
/// 
/// | Dynamic Tag      | Property  | Example                      | Description |
/// | ---------------- | --------- | ---------------------------- | ----------- |
/// | `<console>`      | console   | `<console color="red" background="#000000" bold>text</console>` | All property names can be used as a tag property. |
// ignore: non_constant_identifier_names
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

/// ### Markdown
/// 
/// Apply the markdown to a string using the `ConsoleMarkdown.apply()` method:
/// 
/// ```dart
/// print(ConsoleMarkdown.apply('Hello **World**!'));
/// ```
/// 
/// You can also use the `string.toConsole()` extension method:
/// 
/// ```dart
/// print('Hello, **world**!'.toConsole());
/// 
/// print(
/// 	'''
/// 		Hello **World**!
/// 	__Looks *pretty* easy__
/// 
/// 	<console color="red" background="black" bold> Console Markdown </console>
/// 	'''.toConsole();
/// )
/// ```
///
/// ## Markdown Cheatsheet
/// ### Symbols
/// 
/// | Symbol | Property         | Example        | Result          |
/// | ------ | ---------------- | -------------- | --------------- |
/// | `**`   | bold             | `**text**`     | **text**        |
/// | `*`    | italic           | `*text*`       | *text*          |
/// | `__`   | underline        | `__text__`     | <u>text</u>     |
/// | `~~`   | strikethrough    | `~~text~~`     | ~~text~~        |
/// | `^`    | superscript      | `^text^`       | <sup>text</sup> |
/// | `~`    | subscript        | `~text~`       | <sub>text</sub> |
/// | `___`  | double-underline | `___text___`   |                 |
/// | `!!`   | blink            | `!!text!!`     |                 |
/// | `!!!`  | rapid-blink      | `!!!text!!!`   |                 |
/// | `\|\|` | hidden           | `\|\|text\|\|` |                 |
/// | `^^`   | inverse          | `^^text^^`     |                 |
/// | \`     | dim              | \``text`\`     |                 |
/// 
/// ### Tags
/// 
/// | Tag          | Property         | Example                     |
/// | ------------ | --------         | --------------------------- |
/// | `<reset>`    | reset            | `<reset>text`               |
/// | `<overline>` | overline         | `<overline>text</overline>` |
/// | `<br>`       | line break       | `<br>`                      |
/// | `<b>`        | bold             | `<b>text</b>`               |
/// | `<i>`        | italic           | `<i>text</i>`               |
/// | `<u>`        | underline        | `<u>text</u>`               |
/// | `<uu>`       | double-underline | `<uu>text</uu>`             |
/// | `<s>`        | strikethrough    | `<s>text</s>`               |
/// | `<sup>`      | superscript      | `<sup>text</sup>`           |
/// | `<sub>`      | subscript        | `<sub>text</sub>`           |
/// 
/// **Note:** All Symbol property names can be used as a tag.
/// 
/// ### Colors
/// 
/// The following colors are available as tags:
/// - `black`
/// - `red`
/// - `green`
/// - `yellow`
/// - `blue`
/// - `magenta`
/// - `cyan`
/// - `white`
/// - `gray`
/// 
/// Using the flag `background`, you can set the background color of the text.
/// 
/// ### Dynamic Tags
/// 
/// | Dynamic Tag      | Property  | Example                      | Description |
/// | ---------------- | --------- | ---------------------------- | ----------- |
/// | `<console>`      | console   | `<console color="red" background="#000000" bold>text</console>` | All property names above can be used as a tag property. |
/// | `<rgb(r, g, b)>` | rgb       | `<rgb(255, 0, 0)>text</rgb>` | Can be set as a background by adding a `background` property. |
/// | `<hex([#]...)>`  | hex       | `<hex(#ff0000)>text</hex>`   | Can be set as a background by adding a `background` property. |
/// | `<#...>`         | short hex | `<#ff0000>text</#>`          | Can be set as a background by adding a `background` property. |
// ignore: non_constant_identifier_names
final ConsoleMarkdown = Markdown.map({
  // Tags
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

  // Short Tags
  '<b>': (text, match) => chalk.bold(text),
  '<i>': (text, match) => chalk.italic(text),
  '<u>': (text, match) => chalk.underline(text),
  '<uu>': (text, match) => chalk.doubleunderline(text),
  '<s>': (text, match) => chalk.strikethrough(text),
  '<sup>': (text, match) => chalk.superscript(text),
  '<sub>': (text, match) => chalk.subscript(text),

  // Basic Tags
  'basic: <reset>': (text, match) => chalk.reset(''),
  'basic: <br>': (text, match) => '\n',

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

  r'<hex\(#?(?<color>[0-F]{3}(?:[0-F]{3})?)\) background>': (text, match) {
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
  ... ConsoleMarkdownSymbols.placeholders,
  ... ConsoleMarkdownBasic.placeholders,
});
