import 'package:flutter/services.dart';
import 'package:math_keyboard/src/foundation/node.dart';
import 'package:math_keyboard/src/widgets/keyboard_button.dart';

/// Class representing a button configuration.
abstract class KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const KeyboardButtonConfig({
    this.flex,
    this.keyboardCharacters = const [],
  });

  /// Optional flex.
  final int? flex;

  /// The list of [RawKeyEvent.character] that should trigger this keyboard
  /// button on a physical keyboard.
  ///
  /// Note that the case of the characters is ignored.
  ///
  /// Special keyboard keys like backspace and arrow keys are specially handled
  /// and do *not* require this to be set.
  ///
  /// Must not be `null` but can be empty.
  final List<String> keyboardCharacters;
}

/// Class representing a button configuration for a [FunctionButton].
class BasicKeyboardButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const BasicKeyboardButtonConfig({
    required this.label,
    required this.value,
    this.args,
    this.asTex = false,
    this.highlighted = false,
    List<String> keyboardCharacters = const [],
    int? flex,
  }) : super(
          flex: flex,
          keyboardCharacters: keyboardCharacters,
        );

  /// The label of the button.
  final String label;

  /// The value in tex.
  final String value;

  /// List defining the arguments for the function behind this button.
  final List<TeXArg>? args;

  /// Whether to display the label as TeX or as plain text.
  final bool asTex;

  /// The highlight level of this button.
  final bool highlighted;
}

/// Class representing a button configuration of the Delete Button.
class DeleteButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  DeleteButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Previous Button.
class PreviousButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  PreviousButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Next Button.
class NextButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  NextButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SubmitButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SubmitButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class PageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const PageButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the space Button.
class SpaceButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SpaceButtonConfig].
  const SpaceButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the empty space
class EmptySpaceConfig extends KeyboardButtonConfig {
  /// Constructs a [EmptySpaceConfig]
  const EmptySpaceConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the uppercase toggle
class UppercaseConfig extends KeyboardButtonConfig {
  /// Constructs a [UppercaseConfig]
  const UppercaseConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the alphabet and numeric toggle
class ToggleAlphabetConfig extends KeyboardButtonConfig {
  /// Constructs a [ToggleAlphabetConfig]
  const ToggleAlphabetConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the return button
class ReturnButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [ReturnButtonConfig]
  const ReturnButtonConfig({int? flex}) : super(flex: flex);
}

/// List of keyboard button configs for the digits from 0-9.
///
/// List access from 0 to 9 will return the appropriate digit button.
final _digitButtons = [
  for (var i = 0; i < 10; i++)
    BasicKeyboardButtonConfig(
      label: '$i',
      value: '$i',
      keyboardCharacters: ['$i'],
    ),
];

const _decimalButton = BasicKeyboardButtonConfig(
  label: '.',
  value: '.',
  keyboardCharacters: ['.', ','],
);

const _subtractButton = BasicKeyboardButtonConfig(
  label: '−',
  value: '-',
  keyboardCharacters: ['-'],
);

BasicKeyboardButtonConfig _buildAlphabetBtn(String alphabet) {
  return BasicKeyboardButtonConfig(label: alphabet, value: alphabet);
}

/// alphabet keyboard
final alphabetKeyboard = [
  [
    _buildAlphabetBtn('q'),
    _buildAlphabetBtn('w'),
    _buildAlphabetBtn('e'),
    _buildAlphabetBtn('r'),
    _buildAlphabetBtn('t'),
    _buildAlphabetBtn('y'),
    _buildAlphabetBtn('u'),
    _buildAlphabetBtn('i'),
    _buildAlphabetBtn('o'),
    _buildAlphabetBtn('p'),
  ],
  [
    // EmptySpaceConfig(),
    _buildAlphabetBtn('a'),
    _buildAlphabetBtn('s'),
    _buildAlphabetBtn('d'),
    _buildAlphabetBtn('f'),
    _buildAlphabetBtn('g'),
    _buildAlphabetBtn('h'),
    _buildAlphabetBtn('j'),
    _buildAlphabetBtn('k'),
    _buildAlphabetBtn('l'),
    // EmptySpaceConfig(),
  ],
  [
    UppercaseConfig(),
    _buildAlphabetBtn('z'),
    _buildAlphabetBtn('x'),
    _buildAlphabetBtn('c'),
    _buildAlphabetBtn('v'),
    _buildAlphabetBtn('b'),
    _buildAlphabetBtn('n'),
    _buildAlphabetBtn('m'),
    DeleteButtonConfig(),
  ],
];

/// Keyboard showing toggle abc, space and return
final baseKeyboard = [
  ToggleAlphabetConfig(),
  PreviousButtonConfig(),
  SpaceButtonConfig(),
  NextButtonConfig(),
  SubmitButtonConfig(flex: 2)
];

/// Keyboard showing extended functionality.
final functionKeyboard = [
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _digitButtons[0],
  ],
  [
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\frac',
      keyboardCharacters: ['/'],
      args: [TeXArg.braces, TeXArg.braces],
    ),
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\cdot',
      keyboardCharacters: ['*'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\$',
      value: r'\$',
      keyboardCharacters: ['\$'],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '\u00A2',
      value: '\u00A2',
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ell',
      value: r'\ell',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(label: r'\pi', value: r'\pi', asTex: true),
    const BasicKeyboardButtonConfig(
      label: r'\lt',
      value: r'\lt',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\gt',
      value: r'\gt',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\le',
      value: r'\le',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ge',
      value: r'\ge',
      asTex: true,
    ),
  ],
  [
    const PageButtonConfig(),
    _buildAlphabetBtn('='),
    _buildAlphabetBtn(':'),

    /// degree
    const BasicKeyboardButtonConfig(
      label: '\u00B0',
      value: '\u00B0',
    ),
    _buildAlphabetBtn(','),
    _decimalButton,
    DeleteButtonConfig(),
  ],
  // [
  //   const PageButtonConfig(flex: 3),

  //   DeleteButtonConfig(),
  // ],
];

/// Standard keyboard for math expression input.
final standardKeyboard = [
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _digitButtons[0],
  ],
  [
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
    ),
    _subtractButton,
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      keyboardCharacters: [')'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\Box}',
      value: r'\sqrt',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: ['r'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: [
        '^',
        // This is a workaround for keyboard layout that use ^ as a toggle key.
        // In that case, "Dead" is reported as the character (e.g. for German
        // keyboards).
        'Dead',
      ],
    ),
  ],
  [
    const PageButtonConfig(),
    _buildAlphabetBtn('='),
    _buildAlphabetBtn(':'),

    /// degree
    const BasicKeyboardButtonConfig(
      label: '\u00B0',
      value: '\u00B0',
    ),
    _buildAlphabetBtn(','),
    _decimalButton,
    DeleteButtonConfig(),
  ],
  // [
  //   const PageButtonConfig(),
  //   PreviousButtonConfig(),
  //   NextButtonConfig(),
  //   SubmitButtonConfig(),
  // ],
];

/// Keyboard getting shown for number input only.
final numberKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _subtractButton,
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _decimalButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    DeleteButtonConfig(),
  ],
  [
    PreviousButtonConfig(),
    _digitButtons[0],
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];
