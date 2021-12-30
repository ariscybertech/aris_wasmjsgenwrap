// ignore_for_file: implementation_imports
import 'package:ffigen/ffigen.dart' as ffigen;
import 'package:ffigen/src/header_parser/parser.dart' as ffi_parser;
import 'package:ffigen/src/code_generator.dart' as ffi_codegen;
import 'package:wasmjsgen/src/code_generator.dart';

Library parse(ffigen.Config c) {
  ffi_parser.initParser(c);

  final bindings = ffi_parser
      .parseToBindings()
      .where((ffi_codegen.Binding b) => !b.originalName.startsWith('_'))
      .toList();

  final library = Library();
  /* TODO:
  final library = Library(
    bindings: bindings,
    name: config.wrapperName,
    description: config.wrapperDocComment,
    header: config.preamble,
    dartBool: config.dartBool,
    sort: config.sort,
    packingOverride: config.structPackingOverride,
  );
  */

  return library;
}
