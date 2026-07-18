// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/components/api_card/api_card_widget.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child3/bottom_nav_child3_widget.dart';
import '/components/button/button_widget.dart';
import '/components/checkbox/checkbox_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'a_p_i_settings_widget.dart' show APISettingsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class APISettingsModel extends FlutterFlowModel<APISettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ApiCard.
  late ApiCardModel apiCardModel1;
  // Model for ApiCard.
  late ApiCardModel apiCardModel2;
  // Model for ApiCard.
  late ApiCardModel apiCardModel3;
  // Model for Checkbox.
  late CheckboxModel checkboxModel1;
  // Model for Checkbox.
  late CheckboxModel checkboxModel2;
  // Model for Checkbox.
  late CheckboxModel checkboxModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    apiCardModel1 = createModel(context, () => ApiCardModel());
    apiCardModel2 = createModel(context, () => ApiCardModel());
    apiCardModel3 = createModel(context, () => ApiCardModel());
    checkboxModel1 = createModel(context, () => CheckboxModel());
    checkboxModel2 = createModel(context, () => CheckboxModel());
    checkboxModel3 = createModel(context, () => CheckboxModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    apiCardModel1.dispose();
    apiCardModel2.dispose();
    apiCardModel3.dispose();
    checkboxModel1.dispose();
    checkboxModel2.dispose();
    checkboxModel3.dispose();
    textFieldModel.dispose();
    buttonModel.dispose();
    bottomNavModel.dispose();
  }
}
