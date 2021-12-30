import 'dart:io';

import 'package:ffigen/ffigen.dart' as ffigen;
import 'package:logging/logging.dart';

// ignore: implementation_imports
import 'package:ffigen/src/executables/ffigen.dart' as ffi_exe;
import 'package:wasmjsgen/src/header_parser/parser.dart';

final _logger = Logger('ffigen.ffigen');

void main(List<String> args) {
  final argResult = ffi_exe.getArgResults(args);

  ffi_exe.setupLogger(argResult);

  ffigen.Config config;
  try {
    config = ffi_exe.getConfig(argResult);
  } on FormatException {
    _logger.severe('Please fix configuration errors and re-run the tool.');
    exit(1);
  }
  final library = parse(config);

  final gen = File(config.output);
  library.generateFile(gen);
  _logger.info(ffi_exe
      .successPen('Finished, Bindings generated in ${gen.absolute.path}'));
}
