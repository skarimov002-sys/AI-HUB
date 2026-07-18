// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/components/button/button_widget.dart';
import '/components/chat_bubble/chat_bubble_widget.dart';
import '/components/model_chip/model_chip_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'main_chat_interface_widget.dart' show MainChatInterfaceWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainChatInterfaceModel extends FlutterFlowModel<MainChatInterfaceWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ModelChip.
  late ModelChipModel modelChipModel1;
  // Model for ModelChip.
  late ModelChipModel modelChipModel2;
  // Model for ModelChip.
  late ModelChipModel modelChipModel3;
  // Model for ModelChip.
  late ModelChipModel modelChipModel4;
  // Model for ChatBubble.
  late ChatBubbleModel chatBubbleModel1;
  // Model for ChatBubble.
  late ChatBubbleModel chatBubbleModel2;
  // Model for ChatBubble.
  late ChatBubbleModel chatBubbleModel3;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for TextField.
  late TextFieldModel textFieldModel;

  @override
  void initState(BuildContext context) {
    modelChipModel1 = createModel(context, () => ModelChipModel());
    modelChipModel2 = createModel(context, () => ModelChipModel());
    modelChipModel3 = createModel(context, () => ModelChipModel());
    modelChipModel4 = createModel(context, () => ModelChipModel());
    chatBubbleModel1 = createModel(context, () => ChatBubbleModel());
    chatBubbleModel2 = createModel(context, () => ChatBubbleModel());
    chatBubbleModel3 = createModel(context, () => ChatBubbleModel());
    buttonModel = createModel(context, () => ButtonModel());
    textFieldModel = createModel(context, () => TextFieldModel());
  }

  @override
  void dispose() {
    modelChipModel1.dispose();
    modelChipModel2.dispose();
    modelChipModel3.dispose();
    modelChipModel4.dispose();
    chatBubbleModel1.dispose();
    chatBubbleModel2.dispose();
    chatBubbleModel3.dispose();
    buttonModel.dispose();
    textFieldModel.dispose();
  }
}
