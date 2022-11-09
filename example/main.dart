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
