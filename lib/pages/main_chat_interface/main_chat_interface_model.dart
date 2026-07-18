// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/backend/ai_providers/ai_providers.dart';
import '/components/model_chip/model_chip_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'main_chat_interface_widget.dart' show MainChatInterfaceWidget;
import 'package:flutter/material.dart';

/// A single message in the conversation.
class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });

  final String text;
  final bool isUser;
  final String time;
}

class MainChatInterfaceModel extends FlutterFlowModel<MainChatInterfaceWidget> {
  ///  State fields for stateful widgets in this page.

  /// The provider whose chip is currently selected.
  AiProvider selectedProvider = AiProvider.gemini;

  /// Providers with an API key configured server-side; the rest are shown
  /// as "coming soon". Refreshed from the Cloud Function on page load.
  Set<AiProvider> availableProviders = {AiProvider.gemini};

  /// The conversation so far. When empty, the chat area shows the quick
  /// prompt template cards instead.
  final List<ChatMessage> messages = [];

  /// True while waiting for the AI's reply.
  bool isGenerating = false;

  /// Voice input language: 'uz' (default) or 'ru'. Long-press the mic
  /// button to switch.
  String speechLanguageCode = 'uz';

  /// True while the microphone is actively listening.
  bool isListening = false;

  // Model for ModelChip.
  late ModelChipModel modelChipModel1;
  // Model for ModelChip.
  late ModelChipModel modelChipModel2;
  // Model for ModelChip.
  late ModelChipModel modelChipModel3;
  // Model for ModelChip.
  late ModelChipModel modelChipModel4;
  // Model for TextField.
  late TextFieldModel textFieldModel;

  @override
  void initState(BuildContext context) {
    modelChipModel1 = createModel(context, () => ModelChipModel());
    modelChipModel2 = createModel(context, () => ModelChipModel());
    modelChipModel3 = createModel(context, () => ModelChipModel());
    modelChipModel4 = createModel(context, () => ModelChipModel());
    textFieldModel = createModel(context, () => TextFieldModel());
  }

  @override
  void dispose() {
    modelChipModel1.dispose();
    modelChipModel2.dispose();
    modelChipModel3.dispose();
    modelChipModel4.dispose();
    textFieldModel.dispose();
  }
}
