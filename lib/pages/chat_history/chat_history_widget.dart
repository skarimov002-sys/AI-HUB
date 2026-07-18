import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import '/components/history_item/history_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_history_model.dart';
export 'chat_history_model.dart';

class ChatHistoryWidget extends StatefulWidget {
  const ChatHistoryWidget({super.key});

  static String routeName = 'ChatHistory';
  static String routePath = '/chatHistory';

  @override
  State<ChatHistoryWidget> createState() => _ChatHistoryWidgetState();
}

class _ChatHistoryWidgetState extends State<ChatHistoryWidget> {
  late ChatHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatHistoryModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ChatHistory'});
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'wuc7qcde' /* Chat History */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                          lineHeight: 1.25,
                                        ),
                                  ),
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'erv4s5wy' /* Manage your AI conversations */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                  Icons.tune_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.textFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: '',
                              labelPresent: false,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Search conversations...',
                              value: '',
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                        ].divide(SizedBox(height: 24.0)),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'rlz8hogx' /* TODAY */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Colors.orange,
                                      snippet:
                                          'The syntax looks much cleaner now with the new indentation rules...',
                                      time: '10:45 AM',
                                      title: 'Refactoring Flutter DSL',
                                      model: 'claude',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Color(0xFFFF6D00),
                                      snippet:
                                          'Based on recent trends in the tech sector, we see a shift towards...',
                                      time: '8:12 AM',
                                      title: 'Market Analysis Q4',
                                      model: 'OpenAI',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'b7mkonhu' /* YESTERDAY */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Color(0xFFFFAB40),
                                      snippet:
                                          'The error in the loop was caused by an index out of bounds...',
                                      time: '4:30 PM',
                                      title: 'Python Script Debugging',
                                      model: 'gemini',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Colors.orange,
                                      snippet:
                                          'To get the perfect zest consistency, you should first...',
                                      time: '11:15 AM',
                                      title: 'Recipe: Orange Glazed Cake',
                                      model: 'claude',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Color(0xFFFF6D00),
                                      snippet:
                                          'Day 1: Arrive at Narita, check into Shinjuku hotel, visit...',
                                      time: '9:05 AM',
                                      title: 'Travel Itinerary Tokyo',
                                      model: 'OpenAI',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'c7o5pyfv' /* LAST WEEK */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.2,
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.historyItemModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: HistoryItemWidget(
                                      modelColor: Color(0xFFFFAB40),
                                      snippet:
                                          'Focusing on progressive overload for the next 4 weeks...',
                                      time: 'Oct 12',
                                      title: 'Workout Plan Evolution',
                                      model: 'gemini',
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
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
                    child: () => BottomNavChild2Widget(),
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
