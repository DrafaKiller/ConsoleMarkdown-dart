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

| Symbol                  | Property         | Example                         | Result                           |
| ----------------------- | ---------------- | ------------------------------- | -------------------------------- |
| <center>`**`</center>   | bold             | <center>`**text**`</center>     | <center>**text**</center>        |
| <center>`*`</center>    | italic           | <center>`*text*`</center>       | <center>*text*</center>          |
| <center>`__`</center>   | underline        | <center>`__text__`</center>     | <center><u>text</u></center>     |
| <center>`~~`</center>   | strikethrough    | <center>`~~text~~`</center>     | <center>~~text~~</center>        |
| <center>`^`</center>    | superscript      | <center>`^text^`</center>       | <center><sup>text</sup></center> |
| <center>`~`</center>    | subscript        | <center>`~text~`</center>       | <center><sub>text</sub></center> |
| <center>`___`</center>  | double-underline | <center>`___text___`</center>   |                                  |
| <center>`!!`</center>   | blink            | <center>`!!text!!`</center>     |                                  |
| <center>`!!!`</center>  | rapid-blink      | <center>`!!!text!!!`</center>   |                                  |
| <center>`\|\|`</center> | hidden           | <center>`\|\|text\|\|`</center> |                                  |
| <center>`^^`</center>   | inverse          | <center>`^^text^^`</center>     |                                  |
| <center>\`</center>     | dim              | <center>\``text`\`</center>     |                                  |

| Tag                           | Property | Example                                      |
| ----------------------------- | -------- | -------------------------------------------- |
| <center>`<reset>`</center>    | reset    | <center>`<reset>text`</center>               |
| <center>`<overline>`</center> | overline | <center>`<overline>text</overline>`</center> |

**Note:** All Symbol property names can be used as a tag.

| Dynamic Tag                       | Property  | Example                                       | Description |
| --------------------------------- | --------- | --------------------------------------------- | ----------- |
| <center>`<console>`</center>      | console   | <center>`<console color="red" background="#000000" bold>text</console>`</center> | All property names above can be used as a tag property. |
| <center>`<rgb(r, g, b)>`</center> | rgb       | <center>`<rgb(255, 0, 0)>text</rgb>`</center> | Can be set as a background by adding a `background` property. |
| <center>`<hex([#]...)>`</center>  | hex       | <center>`<hex(#ff0000)>text</hex>`</center>   | Can be set as a background by adding a `background` property. |
| <center>`<#...>`</center>         | short hex | <center>`<#ff0000>text</#>`</center>          | Can be set as a background by adding a `background` property. |

## Markdown syntax alternatives

If you're feeling paranoid about performance, you can use simpler versions of the markdown with only certain placeholders.

| Markdown            | Description                   |
| -------------------------- | ----------------------------- |
| ConsoleMarkdownSymbols | Contains all symbols only.    |
| ConsoleMarkdownBasic  | Contains only the console tag, which can be used to set any of the other properties. |
| ConsoleMarkdown       | Contains all markdown syntax. |

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
