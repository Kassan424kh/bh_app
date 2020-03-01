import 'package:path_provider/path_provider.dart';

class PathProvider{
  static outputPath () async => await getTemporaryDirectory();
}