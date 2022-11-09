[![Pub.dev package](https://img.shields.io/badge/pub.dev-console_markdown-blue)](https://pub.dev/packages/console_markdown)
[![GitHub repository](https://img.shields.io/badge/GitHub-ConsoleMarkdown--dart-blue?logo=github)](https://github.com/DrafaKiller/ConsoleMarkdown-dart)

# Console Markdown

Change the console's style using markdown. Easy to use, with no setup required.

This package uses an implementation of [marked](https://pub.dev/packages/marked) for the Markdown syntax,
and [chalkdart](https://pub.dev/packages/chalkdart) for the console styling.

## Features

* No setup required
* Symbol markdown syntax
* Tags markdown, HTML-like syntax
* Strict markdown syntax option, to avoid mistakes

## Getting started

Install it using pub:
```
dart pub add console_markdown
```

And import the package:
```dart
import 'package:console_markdown/console_markdown.dart';
```

## Usage

Apply the markdown to a string using the `ConsoleMarkdown.apply()` method:

```dart
print(ConsoleMarkdown.apply('Hello **World**!'));
```

You can also use the `string.toConsole()` extension method:

```dart
print('Hello, **world**!'.toConsole());

print(
	'''
		Hello **World**!
	__Looks *pretty* easy__

	<console color="red" background="black" bold> Console Markdown </console>
	'''.toConsole();
)
```

## Markdown Cheatsheet

### Symbols

| Symbol | Property         | Example        | Result          |
| ------ | ---------------- | -------------- | --------------- |
| `**`   | bold             | `**text**`     | **text**        |
| `*`    | italic           | `*text*`       | *text*          |
| `__`   | underline        | `__text__`     | <u>text</u>     |
| `~~`   | strikethrough    | `~~text~~`     | ~~text~~        |
| `^`    | superscript      | `^text^`       | <sup>text</sup> |
| `~`    | subscript        | `~text~`       | <sub>text</sub> |
| `___`  | double-underline | `___text___`   |                 |
| `!!`   | blink            | `!!text!!`     |                 |
| `!!!`  | rapid-blink      | `!!!text!!!`   |                 |
| `\|\|` | hidden           | `\|\|text\|\|` |                 |
| `^^`   | inverse          | `^^text^^`     |                 |
| \`     | dim              | \``text`\`     |                 |

### Tags

| Tag          | Property | Example                     |
| ------------ | -------- | --------------------------- |
| `<reset>`    | reset    | `<reset>text`               |
| `<overline>` | overline | `<overline>text</overline>` |

**Note:** All Symbol property names can be used as a tag.

### Colors

The following colors are available as tags:
- `black`
- `red`
- `green`
- `yellow`
- `blue`
- `magenta`
- `cyan`
- `white`
- `gray`

Using the flag `background`, you can set the background color of the text.

### Dynamic Tags

| Dynamic Tag      | Property  | Example                      | Description |
| ---------------- | --------- | ---------------------------- | ----------- |
| `<console>`      | console   | `<console color="red" background="#000000" bold>text</console>` | All property names above can be used as a tag property. |
| `<rgb(r, g, b)>` | rgb       | `<rgb(255, 0, 0)>text</rgb>` | Can be set as a background by adding a `background` property. |
| `<hex([#]...)>`  | hex       | `<hex(#ff0000)>text</hex>`   | Can be set as a background by adding a `background` property. |
| `<#...>`         | short hex | `<#ff0000>text</#>`          | Can be set as a background by adding a `background` property. |

## Markdown syntax alternatives

If you're feeling paranoid about performance, you can use simpler versions of the markdown with only certain placeholders.

| Markdown               | Description                   |
| ---------------------- | ----------------------------- |
| ConsoleMarkdownSymbols | Contains all symbols only.    |
| ConsoleMarkdownBasic   | Contains only the console tag, which can be used to set any of the other properties. |
| ConsoleMarkdown        | Contains all markdown syntax. |

## Example

```dart
import 'package:console_markdown/console_markdown.dart';

void main() {
  print(
    '''
      Hello **World**!
      __Looks *pretty* easy__

      <console color="red" background="black" bold> Console Markdown </console>
    '''.toConsole()
  );
}
```
