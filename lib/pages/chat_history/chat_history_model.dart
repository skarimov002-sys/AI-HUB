import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import '/components/history_item/history_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'chat_history_widget.dart' show ChatHistoryWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatHistoryModel extends FlutterFlowModel<ChatHistoryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel1;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel2;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel3;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel4;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel5;
  // Model for HistoryItem.
  late HistoryItemModel historyItemModel6;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    historyItemModel1 = createModel(context, () => HistoryItemModel());
    historyItemModel2 = createModel(context, () => HistoryItemModel());
    historyItemModel3 = createModel(context, () => HistoryItemModel());
    historyItemModel4 = createModel(context, () => HistoryItemModel());
    historyItemModel5 = createModel(context, () => HistoryItemModel());
    historyItemModel6 = createModel(context, () => HistoryItemModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    historyItemModel1.dispose();
    historyItemModel2.dispose();
    historyItemModel3.dispose();
    historyItemModel4.dispose();
    historyItemModel5.dispose();
    historyItemModel6.dispose();
    bottomNavModel.dispose();
  }
}
