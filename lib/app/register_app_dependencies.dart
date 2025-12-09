import 'package:library_app/core.dart';
import 'package:library_app/data/data_dependencies.dart';
import 'package:library_app/presentation/presentation_dependencies.dart';
import 'package:library_app/shared.dart';

Future<void> registerAppSharedDependencies({
  required DI di,
}) async {
  final dependenciesList = <PackageDependencies>[
    SharedDependencies(),
    DataDependencies(),
    PresentationDependencies(),
  ];

  for (final dependencies in dependenciesList) {
    await dependencies.register(di);
  }
}