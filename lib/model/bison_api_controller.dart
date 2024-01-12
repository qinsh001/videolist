
class BisonApiController {
  List<Candidates>? candidates;

  BisonApiController({this.candidates});

  BisonApiController.fromJson(Map<String, dynamic> json) {
    if(json["candidates"] is List) {
      candidates = json["candidates"] == null ? null : (json["candidates"] as List).map((e) => Candidates.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(candidates != null) {
      data["candidates"] = candidates?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Candidates {
  String? output;
  List<SafetyRatings>? safetyRatings;

  Candidates({this.output, this.safetyRatings});

  Candidates.fromJson(Map<String, dynamic> json) {
    if(json["output"] is String) {
      output = json["output"];
    }
    if(json["safetyRatings"] is List) {
      safetyRatings = json["safetyRatings"] == null ? null : (json["safetyRatings"] as List).map((e) => SafetyRatings.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["output"] = output;
    if(safetyRatings != null) {
      data["safetyRatings"] = safetyRatings?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class SafetyRatings {
  String? category;
  String? probability;

  SafetyRatings({this.category, this.probability});

  SafetyRatings.fromJson(Map<String, dynamic> json) {
    if(json["category"] is String) {
      category = json["category"];
    }
    if(json["probability"] is String) {
      probability = json["probability"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category"] = category;
    data["probability"] = probability;
    return data;
  }
}