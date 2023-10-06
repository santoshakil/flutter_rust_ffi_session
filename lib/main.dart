import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bundle = await rootBundle.load('assets/librust_core.dylib');
  final docDir = await getApplicationDocumentsDirectory();
  final libPath = join(docDir.path, 'librust_core.dylib');
  final libFile = File(libPath);
  if (!libFile.existsSync()) {
    await libFile.create(recursive: true);
  }
  await libFile.writeAsBytes(bundle.buffer.asUint8List());
  runApp(const MainApp());
}

typedef TypeF = ffi.Void Function();
typedef TypeD = void Function();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Row(
              children: [
                Text('FFI'),
                SizedBox(width: 8),
                CircularProgressIndicator(),
              ],
            ),
            onPressed: () async {
              final docDir = await getApplicationDocumentsDirectory();
              final libPath = join(docDir.path, 'librust_core.dylib');
              final dylib = ffi.DynamicLibrary.open(libPath);
              final rustFunction = dylib.lookupFunction<TypeF, TypeD>('run_rust_task_ffi');
              rustFunction();
              // await Isolate.spawn(
              //   (path) {
              //     final dylib = ffi.DynamicLibrary.open(libPath);
              //     final rustFunction = dylib.lookupFunction<TypeF, TypeD>('run_rust_task_ffi');
              //     rustFunction();
              //   },
              //   [libPath],
              // );
            },
          ),
        ),
      ),
    );
  }
}
