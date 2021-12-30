import 'dart:io';
import 'package:cli_util/cli_util.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'binding.dart';
import 'writer.dart';

final _logger = Logger('wasmjsgen.code_generator.library');

class Library {
  late List<Binding> bindings;

  late Writer _writer;
  Writer get writer => _writer;

  void generateFile(File file, {bool format = true}) {
    if (!file.existsSync()) file.createSync(recursive: true);
    file.writeAsStringSync(generate());
    if (format) {
      _dartFormat(file.path);
    }
  }

  String generate() {
    return writer.generate();
  }

  /// Formats a file using the Dart formatter.
  void _dartFormat(String path) {
    final sdkPath = getSdkPath();
    final result = Process.runSync(
        p.join(sdkPath, 'bin', 'dart'), ['format', path],
        runInShell: Platform.isWindows);
    if (result.stderr.toString().isNotEmpty) {
      _logger.severe(result.stderr);
      throw FormatException('Unable to format generated file: $path.');
    }
  }
}
