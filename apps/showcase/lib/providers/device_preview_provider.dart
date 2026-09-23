import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PreviewDevice { mobile, tablet, desktop }

final previewDeviceProvider =
    StateProvider<PreviewDevice>((ref) => PreviewDevice.mobile);
