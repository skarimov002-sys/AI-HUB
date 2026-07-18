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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'a_p_i_settings_model.dart';
export 'a_p_i_settings_model.dart';

class APISettingsWidget extends StatefulWidget {
  const APISettingsWidget({super.key});

  static String routeName = 'APISettings';
  static String routePath = '/aPISettings';

  @override
  State<APISettingsWidget> createState() => _APISettingsWidgetState();
}

class _APISettingsWidgetState extends State<APISettingsWidget> {
  late APISettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => APISettingsModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'APISettings'});
  }

  @override
  void dispose() {
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
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'p3d9q88q' /* API Credentials */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.outfit(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                      lineHeight: 1.3,
                                    ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'wc74yrvo' /* Manage your AI provider integr... */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.help_outline_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
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
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0x14FF6B00),
                                  borderRadius: BorderRadius.circular(18.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Color(0x33FF6B00),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.info_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .onSecondary,
                                          size: 24.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'gouiskni' /* Nexus AI Hub uses your own key... */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .onSecondary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                          lineHeight: 1.3,
                                                        ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'q7gk6q57' /* Keys are stored locally on you... */,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .plusJakartaSans(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .onSecondary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                          lineHeight: 1.4,
                                                        ),
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.apiCardModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: ApiCardWidget(
                                  icon: Icon(
                                    Icons.smart_toy_rounded,
                                    color: Color(0xFFFF6B00),
                                    size: 24.0,
                                  ),
                                  name: 'OpenAI',
                                  slug: 'openai',
                                  tone: Color(0xFFFF6B00),
                                  connected: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.apiCardModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: ApiCardWidget(
                                  icon: Icon(
                                    Icons.psychology_rounded,
                                    color: Color(0xFFFF6B00),
                                    size: 24.0,
                                  ),
                                  name: 'Anthropic (Claude)',
                                  slug: 'claude',
                                  tone: Color(0xFFD97706),
                                  connected: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.apiCardModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: ApiCardWidget(
                                  icon: Icon(
                                    Icons.auto_awesome_rounded,
                                    color: Color(0xFFFF6B00),
                                    size: 24.0,
                                  ),
                                  name: 'Google Cloud (Gemini)',
                                  slug: 'gemini',
                                  tone: Color(0xFF3B82F6),
                                  connected: false,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Container(
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'hsvc9puu' /* Advanced Options */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(18.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        wrapWithModel(
                                          model: _model.checkboxModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: CheckboxWidget(
                                            label: 'Stream Responses',
                                            subtitle:
                                                'Enable real-time token generation',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            isChecked: true,
                                            hasSubtitle: true,
                                            disabled: false,
                                          ),
                                        ),
                                        Divider(
                                          height: 16.0,
                                          thickness: 1.0,
                                          indent: 24.0,
                                          endIndent: 0.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        wrapWithModel(
                                          model: _model.checkboxModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: CheckboxWidget(
                                            label: 'Request Logs',
                                            subtitle:
                                                'Store local history of API calls',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            isChecked: false,
                                            hasSubtitle: true,
                                            disabled: false,
                                          ),
                                        ),
                                        Divider(
                                          height: 16.0,
                                          thickness: 1.0,
                                          indent: 24.0,
                                          endIndent: 0.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        wrapWithModel(
                                          model: _model.checkboxModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: CheckboxWidget(
                                            label: 'Usage Limits',
                                            subtitle:
                                                'Warn when spending exceeds threshold',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            isChecked: true,
                                            hasSubtitle: true,
                                            disabled: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              wrapWithModel(
                                model: _model.textFieldModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Organization ID (Optional)',
                                  labelPresent: true,
                                  helper:
                                      'Specific to OpenAI enterprise accounts',
                                  helperPresent: true,
                                  leadingIconPresent: false,
                                  trailingIconPresent: false,
                                  hint: 'org-...',
                                  value: '',
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'outlined',
                                  error: false,
                                ),
                              ),
                              Container(
                                child: Container(
                                  width: 0.0,
                                  height: 0.0,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.buttonModel,
                                updateCallback: () => safeSetState(() {}),
                                child: ButtonWidget(
                                  icon: Icon(
                                    Icons.delete_forever_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  iconPresent: true,
                                  iconEndPresent: false,
                                  content: 'Reset All Keys',
                                  variant: 'destructive',
                                  size: 'medium',
                                  fullWidth: true,
                                  loading: false,
                                  disabled: false,
                                ),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Container(
                child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BottomNavWidget(
                    child: () => BottomNavChild3Widget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
