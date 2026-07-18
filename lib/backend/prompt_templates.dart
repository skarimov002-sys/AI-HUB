// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:flutter/material.dart';

/// A quick-start prompt template shown on the empty chat screen.
/// Tapping a card inserts [starterPrompt] into the input field so the user
/// can finish the sentence before sending.
class PromptTemplate {
  const PromptTemplate({
    required this.title,
    required this.description,
    required this.icon,
    required this.starterPrompt,
  });

  final String title;
  final String description;
  final IconData icon;
  final String starterPrompt;
}

const List<PromptTemplate> promptTemplates = [
  PromptTemplate(
    title: 'Referat yozish',
    description: 'Berilgan mavzuda referat tayyorlash',
    icon: Icons.article_rounded,
    starterPrompt: 'Menga quyidagi mavzuda referat yozib bering: ',
  ),
  PromptTemplate(
    title: 'Matnni tarjima qilish',
    description: 'Matnni boshqa tilga tarjima qilish',
    icon: Icons.translate_rounded,
    starterPrompt: 'Quyidagi matnni ingliz tiliga tarjima qiling: ',
  ),
  PromptTemplate(
    title: 'Matnni tuzatish',
    description: 'Imlo va uslub xatolarini tuzatish',
    icon: Icons.spellcheck_rounded,
    starterPrompt: 'Quyidagi matndagi xatolarni tuzatib bering: ',
  ),
  PromptTemplate(
    title: 'Insho yozish',
    description: 'Berilgan mavzuda insho yozish',
    icon: Icons.edit_note_rounded,
    starterPrompt: 'Menga quyidagi mavzuda insho yozib bering: ',
  ),
  PromptTemplate(
    title: 'Savolga javob',
    description: 'Savolga batafsil javob olish',
    icon: Icons.help_outline_rounded,
    starterPrompt: 'Quyidagi savolga batafsil javob bering: ',
  ),
];
