// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/components/button/button_widget.dart';
import '/components/density_option/density_option_widget.dart';
import '/components/slider/slider_widget.dart';
import '/components/switch_component/switch_component_widget.dart';
import '/components/theme_preview_bubble/theme_preview_bubble_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'theme_personalization_widget.dart' show ThemePersonalizationWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThemePersonalizationModel
    extends FlutterFlowModel<ThemePersonalizationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ThemePreviewBubble.
  late ThemePreviewBubbleModel themePreviewBubbleModel1;
  // Model for ThemePreviewBubble.
  late ThemePreviewBubbleModel themePreviewBubbleModel2;
  // Model for Slider.
  late SliderModel sliderModel1;
  // Model for Slider.
  late SliderModel sliderModel2;
  // Model for Slider.
  late SliderModel sliderModel3;
  // Model for DensityOption.
  late DensityOptionModel densityOptionModel1;
  // Model for DensityOption.
  late DensityOptionModel densityOptionModel2;
  // Model for DensityOption.
  late DensityOptionModel densityOptionModel3;
  // Model for Switch.
  late SwitchComponentModel switchModel1;
  // Model for Switch.
  late SwitchComponentModel switchModel2;
  // Model for Switch.
  late SwitchComponentModel switchModel3;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    themePreviewBubbleModel1 =
        createModel(context, () => ThemePreviewBubbleModel());
    themePreviewBubbleModel2 =
        createModel(context, () => ThemePreviewBubbleModel());
    sliderModel1 = createModel(context, () => SliderModel());
    sliderModel2 = createModel(context, () => SliderModel());
    sliderModel3 = createModel(context, () => SliderModel());
    densityOptionModel1 = createModel(context, () => DensityOptionModel());
    densityOptionModel2 = createModel(context, () => DensityOptionModel());
    densityOptionModel3 = createModel(context, () => DensityOptionModel());
    switchModel1 = createModel(context, () => SwitchComponentModel());
    switchModel2 = createModel(context, () => SwitchComponentModel());
    switchModel3 = createModel(context, () => SwitchComponentModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    themePreviewBubbleModel1.dispose();
    themePreviewBubbleModel2.dispose();
    sliderModel1.dispose();
    sliderModel2.dispose();
    sliderModel3.dispose();
    densityOptionModel1.dispose();
    densityOptionModel2.dispose();
    densityOptionModel3.dispose();
    switchModel1.dispose();
    switchModel2.dispose();
    switchModel3.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
