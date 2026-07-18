import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/model_response_card/model_response_card_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'model_comparison_widget.dart' show ModelComparisonWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModelComparisonModel extends FlutterFlowModel<ModelComparisonWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ModelResponseCard.
  late ModelResponseCardModel modelResponseCardModel1;
  // Model for ModelResponseCard.
  late ModelResponseCardModel modelResponseCardModel2;
  // Model for ModelResponseCard.
  late ModelResponseCardModel modelResponseCardModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    modelResponseCardModel1 =
        createModel(context, () => ModelResponseCardModel());
    modelResponseCardModel2 =
        createModel(context, () => ModelResponseCardModel());
    modelResponseCardModel3 =
        createModel(context, () => ModelResponseCardModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    modelResponseCardModel1.dispose();
    modelResponseCardModel2.dispose();
    modelResponseCardModel3.dispose();
    textFieldModel.dispose();
    bottomNavModel.dispose();
  }
}
