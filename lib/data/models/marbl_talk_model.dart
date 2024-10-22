import 'dart:convert';

import '../../domain/entities/marbl_talk_entitie.dart';


MarblTalkModel marblTalkResFromJson(String str) =>
    MarblTalkModel.fromJson(json.decode(str));

String marblTalkResToJson(MarblTalkModel data) => json.encode(data.toJson());

class MarblTalkModel extends MarblTalkEntity {
  MarblTalkModel({required super.candidates, required super.usageMetadata});

  factory MarblTalkModel.fromJson(Map<String, dynamic> json) =>
      MarblTalkModel(
        candidates: List<CandidateModel>.from(
            json["candidates"].map((x) => CandidateModel.fromJson(x))),
        usageMetadata: UsageMetadataModel.fromJson(json["usageMetadata"]),
      );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates.map((x) => x)),
    "usageMetadata": usageMetadata,
  };
}

class CandidateModel extends CandidateEntity {
  CandidateModel(
      {required super.content,
        required super.finishReason,
        required super.index,
        required super.safetyRatings});

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
    content: ContentModel.fromJson(json["content"]),
    finishReason: json["finishReason"],
    index: json["index"],
    safetyRatings: List<SafetyRatingModel>.from(
        json["safetyRatings"].map((x) => SafetyRatingModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "finishReason": finishReason,
    "index": index,
    "safetyRatings": List<dynamic>.from(safetyRatings.map((x) => x)),
  };
}

class ContentModel extends ContentEntity {
  ContentModel({required super.parts, required super.role});

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
    parts: List<PartModel>.from(
        json["parts"].map((x) => PartModel.fromJson(x))),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "parts": List<dynamic>.from(parts.map((x) => x)),
    "role": role,
  };
}

class PartModel extends PartEntity {
  PartModel({required super.text});

  factory PartModel.fromJson(Map<String, dynamic> json) => PartModel(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class SafetyRatingModel extends SafetyRatingEntity {
  SafetyRatingModel({required super.category, required super.probability});

  factory SafetyRatingModel.fromJson(Map<String, dynamic> json) =>
      SafetyRatingModel(
        category: json["category"],
        probability: json["probability"],
      );

  Map<String, dynamic> toJson() => {
    "category": category,
    "probability": probability,
  };
}

class UsageMetadataModel extends UsageMetadataEntity {
  UsageMetadataModel(
      {required super.promptTokenCount,
        required super.candidatesTokenCount,
        required super.totalTokenCount});

  factory UsageMetadataModel.fromJson(Map<String, dynamic> json) =>
      UsageMetadataModel(
        promptTokenCount: json["promptTokenCount"],
        candidatesTokenCount: json["candidatesTokenCount"],
        totalTokenCount: json["totalTokenCount"],
      );

  Map<String, dynamic> toJson() => {
    "promptTokenCount": promptTokenCount,
    "candidatesTokenCount": candidatesTokenCount,
    "totalTokenCount": totalTokenCount,
  };
}