// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import '/backend/ai_providers/ai_providers.dart';
import '/backend/prompt_templates.dart';
import '/backend/speech/speech_input.dart';
import '/components/chat_bubble/chat_bubble_widget.dart';
import '/components/model_chip/model_chip_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_chat_interface_model.dart';
export 'main_chat_interface_model.dart';

class MainChatInterfaceWidget extends StatefulWidget {
  const MainChatInterfaceWidget({super.key});

  static String routeName = 'MainChatInterface';
  static String routePath = '/mainChatInterface';

  @override
  State<MainChatInterfaceWidget> createState() =>
      _MainChatInterfaceWidgetState();
}

class _MainChatInterfaceWidgetState extends State<MainChatInterfaceWidget> {
  late MainChatInterfaceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final SpeechInput _speech = SpeechInput();
  final ScrollController _chatScrollController = ScrollController();

  // The text already in the input field when listening started; recognized
  // speech is appended after it.
  String _textBeforeSpeech = '';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainChatInterfaceModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'MainChatInterface'});

    // Ask the server which AI providers have keys configured; chips for the
    // others render as "coming soon".
    fetchAvailableProviders().then((providers) {
      if (!mounted) {
        return;
      }
      _model.availableProviders = providers;
      if (!providers.contains(_model.selectedProvider) &&
          providers.isNotEmpty) {
        _model.selectedProvider = providers.first;
      }
      safeSetState(() {});
    });
  }

  bool _isAvailable(AiProvider provider) =>
      _model.availableProviders.contains(provider);

  void _selectProvider(AiProvider provider) {
    if (!_isAvailable(provider)) {
      showSnackbar(
        context,
        '${provider.displayName} tez orada qo\'shiladi — API kaliti hali sozlanmagan.',
      );
      return;
    }
    safeSetState(() => _model.selectedProvider = provider);
  }

  TextEditingController? get _inputController =>
      _model.textFieldModel.inputTextController;

  /// Fills the input field with a template's starter prompt so the user can
  /// finish the sentence before sending.
  void _applyTemplate(PromptTemplate template) {
    _inputController?.text = template.starterPrompt;
    _inputController?.selection = TextSelection.collapsed(
      offset: template.starterPrompt.length,
    );
    _model.textFieldModel.inputFocusNode?.requestFocus();
    safeSetState(() {});
  }

  void _scrollChatToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chatScrollController.hasClients) {
        _chatScrollController
            .jumpTo(_chatScrollController.position.maxScrollExtent);
      }
    });
  }

  String _nowTime() => dateTimeFormat('HH:mm', getCurrentTimestamp);

  Future<void> _sendMessage() async {
    final text = _inputController?.text.trim() ?? '';
    if (text.isEmpty || _model.isGenerating) {
      return;
    }
    if (!_isAvailable(_model.selectedProvider)) {
      showSnackbar(
        context,
        '${_model.selectedProvider.displayName} tez orada qo\'shiladi — API kaliti hali sozlanmagan.',
      );
      return;
    }
    if (_speech.isListening) {
      await _speech.stop();
      _model.isListening = false;
    }

    safeSetState(() {
      _model.messages
          .add(ChatMessage(text: text, isUser: true, time: _nowTime()));
      _model.isGenerating = true;
      _inputController?.clear();
    });
    _scrollChatToBottom();

    final reply = await aiGenerateText(context, _model.selectedProvider, text);
    if (!mounted) {
      return;
    }
    safeSetState(() {
      _model.isGenerating = false;
      if (reply != null && reply.isNotEmpty) {
        _model.messages
            .add(ChatMessage(text: reply, isUser: false, time: _nowTime()));
      }
    });
    _scrollChatToBottom();
  }

  /// Tap: start/stop voice input. The recognized words are appended to
  /// whatever was already typed.
  Future<void> _toggleListening() async {
    if (_speech.isListening) {
      await _speech.stop();
      safeSetState(() => _model.isListening = false);
      return;
    }

    final available = await _speech.init(onStatus: (status) {
      if ((status == 'done' || status == 'notListening' || status == 'error') &&
          mounted) {
        safeSetState(() => _model.isListening = false);
      }
    });
    if (!mounted) {
      return;
    }
    if (!available) {
      showSnackbar(context, 'Ovozli kiritish bu qurilmada mavjud emas.');
      return;
    }

    _textBeforeSpeech =
        _inputController != null && _inputController!.text.isNotEmpty
            ? '${_inputController!.text.trimRight()} '
            : '';
    final started =
        await _speech.start(_model.speechLanguageCode, (recognizedText) {
      _inputController?.text = '$_textBeforeSpeech$recognizedText';
      _inputController?.selection = TextSelection.collapsed(
        offset: _inputController!.text.length,
      );
    });
    if (!mounted) {
      return;
    }
    if (!started) {
      showSnackbar(
        context,
        _model.speechLanguageCode == 'uz'
            ? 'Bu qurilmada o\'zbekcha ovozni aniqlash mavjud emas.'
            : 'Bu qurilmada ruscha ovozni aniqlash mavjud emas.',
      );
      return;
    }
    safeSetState(() => _model.isListening = true);
  }

  /// Long-press: switch the voice input language between Uzbek and Russian.
  void _toggleSpeechLanguage() {
    safeSetState(() {
      _model.speechLanguageCode =
          _model.speechLanguageCode == 'uz' ? 'ru' : 'uz';
    });
    showSnackbar(
      context,
      _model.speechLanguageCode == 'uz'
          ? 'Ovoz tili: O\'zbekcha'
          : 'Ovoz tili: Ruscha',
    );
  }

  /// Shown when the conversation is empty: a welcome heading plus the quick
  /// prompt template cards.
  Widget _buildEmptyChatState(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            Text(
              'Nimadan boshlaymiz?',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Quyidagi shablonlardan birini tanlang yoki o\'z savolingizni yozing.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.plusJakartaSans(),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 24.0),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: promptTemplates
                  .map((template) => _buildTemplateCard(context, template))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(BuildContext context, PromptTemplate template) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () => _applyTemplate(template),
      child: Container(
        width: 160.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              template.icon,
              color: FlutterFlowTheme.of(context).primary,
              size: 28.0,
            ),
            SizedBox(height: 12.0),
            Text(
              template.title,
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 4.0),
            Text(
              template.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.plusJakartaSans(),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    _chatScrollController.dispose();
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.menu_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'MAIN_CHAT_INTERFACE_IconButton_ON_TAP');
                                  logFirebaseEvent('IconButton_navigate_to');

                                  context.goNamed(ChatHistoryWidget.routeName);
                                },
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'yy24xu8y' /* Nexus AI Hub */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                          lineHeight: 1.3,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '041hn6js' /* Anthropic · Claude 3.5 Sonnet */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.tune_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'MAIN_CHAT_INTERFACE_IconButton_ON_TAP');
                                  logFirebaseEvent('IconButton_navigate_to');

                                  context.goNamed(APISettingsWidget.routeName);
                                },
                              ),
                              Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary10,
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'cwfjtors' /* AR */,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.spaceGrotesk(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontSize: 12.16,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.3,
                                      ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 56.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                child: Container(
                  child: Container(
                    height: 40.0,
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 16.0),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _selectProvider(AiProvider.claude),
                                    child: wrapWithModel(
                                      model: _model.modelChipModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ModelChipWidget(
                                        icon: Icon(
                                          Icons.auto_awesome_rounded,
                                          color: _model.selectedProvider ==
                                                  AiProvider.claude
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 16.0,
                                        ),
                                        name: AiProvider.claude.displayName,
                                        active: _model.selectedProvider ==
                                            AiProvider.claude,
                                        comingSoon:
                                            !_isAvailable(AiProvider.claude),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _selectProvider(AiProvider.gemini),
                                    child: wrapWithModel(
                                      model: _model.modelChipModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ModelChipWidget(
                                        icon: Icon(
                                          Icons.memory_rounded,
                                          color: _model.selectedProvider ==
                                                  AiProvider.gemini
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 16.0,
                                        ),
                                        name: AiProvider.gemini.displayName,
                                        active: _model.selectedProvider ==
                                            AiProvider.gemini,
                                        comingSoon:
                                            !_isAvailable(AiProvider.gemini),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _selectProvider(AiProvider.gpt),
                                    child: wrapWithModel(
                                      model: _model.modelChipModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ModelChipWidget(
                                        icon: Icon(
                                          Icons.smart_toy_rounded,
                                          color: _model.selectedProvider ==
                                                  AiProvider.gpt
                                              ? FlutterFlowTheme.of(context)
                                                  .onPrimary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          size: 16.0,
                                        ),
                                        name: AiProvider.gpt.displayName,
                                        active: _model.selectedProvider ==
                                            AiProvider.gpt,
                                        comingSoon:
                                            !_isAvailable(AiProvider.gpt),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => showSnackbar(
                                      context,
                                      'Llama 3 is coming soon.',
                                    ),
                                    child: wrapWithModel(
                                      model: _model.modelChipModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ModelChipWidget(
                                        icon: Icon(
                                          Icons.psychology_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 16.0,
                                        ),
                                        name: 'Llama 3',
                                        active: false,
                                        comingSoon: true,
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: _model.messages.isEmpty
                  ? _buildEmptyChatState(context)
                  : SingleChildScrollView(
                      controller: _chatScrollController,
                      primary: false,
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ..._model.messages.map(
                              (message) => ChatBubbleWidget(
                                message: message.text,
                                time: message.time,
                                tone: Color(0x26FF9800),
                                role: message.isUser
                                    ? 'user'
                                    : _model.selectedProvider.id,
                              ),
                            ),
                            if (_model.isGenerating)
                              ChatBubbleWidget(
                                message: 'Yozmoqda...',
                                time: '',
                                tone: Color(0x26FF9800),
                                role: _model.selectedProvider.id,
                              ),
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              Expanded(
                                flex: 1,
                                child: wrapWithModel(
                                  model: _model.textFieldModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: '',
                                    labelPresent: false,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIconPresent: false,
                                    trailingIconPresent: false,
                                    hint: 'Nexus\'dan xohlagan narsangizni so\'rang...',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'ghost',
                                    error: false,
                                  ),
                                ),
                              ),
                              // Voice input: tap to talk, long-press to
                              // switch language (Uzbek/Russian).
                              GestureDetector(
                                onLongPress: _toggleSpeechLanguage,
                                child: FlutterFlowIconButton(
                                  borderRadius: 9999.0,
                                  buttonSize: 48.0,
                                  fillColor: _model.isListening
                                      ? FlutterFlowTheme.of(context).error
                                      : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  icon: Icon(
                                    _model.isListening
                                        ? Icons.mic_rounded
                                        : Icons.mic_none_rounded,
                                    color: _model.isListening
                                        ? FlutterFlowTheme.of(context).onPrimary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: _toggleListening,
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: _sendMessage,
                                child: Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: _model.isGenerating
                                        ? FlutterFlowTheme.of(context).alternate
                                        : FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(9999.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Icon(
                                    Icons.arrow_upward_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .onSecondary,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 34.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.language_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 16.0,
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'vzgjj2k4' /* Web Search */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                          lineHeight: 1.2,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 6.0)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 34.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.code_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 16.0,
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'bcl55nuv' /* Code Interpreter */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                          lineHeight: 1.2,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 6.0)),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '52elg7rl' /* 2,450 tokens remaining */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
