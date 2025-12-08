import 'package:library_app/core.dart';
import 'package:library_app/presentation/presentation_dependencies.dart';

Future<void> registerAppSharedDependencies({
  required DI di,
}) async {
  final dependenciesList = <PackageDependencies>[
    PresentationDependencies(),
  ];

  for (final dependencies in dependenciesList) {
    await dependencies.register(di);
  }
}