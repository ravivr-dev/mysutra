import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:my_sutra/core/components/config/theme/colors.dart';

import 'fonts/montserra_fonts.dart';

class AppTheme extends AiloitteTheme {
  PublicSansFonts get publicSansFonts {
    return PublicSansFonts();
  }

  @override
  ComponentColors get colors {
    return ComponentColors();
  }
}
