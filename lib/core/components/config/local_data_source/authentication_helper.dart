import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:my_sutra/core/components/config/local_data_source/local_data_source.dart';

class ComponentAuthenticationHelper extends AiloitteAuthenticationHelper {
  final ComponentLocalDataSource localDataSource;

  ComponentAuthenticationHelper({
    required this.localDataSource,
  }) : super(localDataSource: localDataSource);
}
