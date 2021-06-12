import 'dart:convert';

import 'package:flutter/foundation.dart';

class MovieList {
  final List<Result> result;
  final QueryParam queryParam;
  final int code;
  final String message;
  MovieList({
    required this.result,
    required this.queryParam,
    required this.code,
    required this.message,
  });

  MovieList copyWith({
    List<Result>? result,
    QueryParam? queryParam,
    int? code,
    String? message,
  }) {
    return MovieList(
      result: result ?? this.result,
      queryParam: queryParam ?? this.queryParam,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result.map((x) => x.toMap()).toList(),
      'queryParam': queryParam.toMap(),
      'code': code,
      'message': message,
    };
  }

  factory MovieList.fromMap(Map<String, dynamic> map) {
    if (map == null) print('null');
    return MovieList(
      result: map['result'] == null
          ? []
          : List<Result>.from(map['result']?.map((x) => Result.fromMap(x))),
      queryParam: QueryParam.fromMap(map['queryParam']),
      code: map['code']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieList.fromJson(String source) =>
      MovieList.fromMap(Map<String, dynamic>.from(jsonDecode(source)));

  @override
  String toString() {
    return 'MovieList(result: $result, queryParam: $queryParam, code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieList &&
        listEquals(other.result, result) &&
        other.queryParam == queryParam &&
        other.code == code &&
        other.message == message;
  }

  @override
  int get hashCode {
    return result.hashCode ^
        queryParam.hashCode ^
        code.hashCode ^
        message.hashCode;
  }
}

class Result {
  final String id;
  final String description;
  final List<String> director;
  final List<String> writers;
  final List<String> stars;
  final List<String> productionCompany;
  final int pageViews;
  final List<dynamic> upVoted;
  final List<String> downVoted;
  final String title;
  final String language;
  final int runTime;
  final int releasedDate;
  final String genre;
  final List<Voted> voted;
  final String poster;
  final int totalVoted;
  final int voting;
  Result({
    required this.id,
    required this.description,
    required this.director,
    required this.writers,
    required this.stars,
    required this.productionCompany,
    required this.pageViews,
    required this.upVoted,
    required this.downVoted,
    required this.title,
    required this.language,
    required this.runTime,
    required this.releasedDate,
    required this.genre,
    required this.voted,
    required this.poster,
    required this.totalVoted,
    required this.voting,
  });

  Result copyWith({
    String? id,
    String? description,
    List<String>? director,
    List<String>? writers,
    List<String>? stars,
    List<String>? productionCompany,
    int? pageViews,
    List<dynamic>? upVoted,
    List<String>? downVoted,
    String? title,
    String? language,
    int? runTime,
    int? releasedDate,
    String? genre,
    List<Voted>? voted,
    String? poster,
    int? totalVoted,
    int? voting,
  }) {
    return Result(
      id: id ?? this.id,
      description: description ?? this.description,
      director: director ?? this.director,
      writers: writers ?? this.writers,
      stars: stars ?? this.stars,
      productionCompany: productionCompany ?? this.productionCompany,
      pageViews: pageViews ?? this.pageViews,
      upVoted: upVoted ?? this.upVoted,
      downVoted: downVoted ?? this.downVoted,
      title: title ?? this.title,
      language: language ?? this.language,
      runTime: runTime ?? this.runTime,
      releasedDate: releasedDate ?? this.releasedDate,
      genre: genre ?? this.genre,
      voted: voted ?? this.voted,
      poster: poster ?? this.poster,
      totalVoted: totalVoted ?? this.totalVoted,
      voting: voting ?? this.voting,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'description': description,
      'director': director,
      'writers': writers,
      'stars': stars,
      'productionCompany': productionCompany,
      'pageViews': pageViews,
      'upVoted': upVoted,
      'downVoted': downVoted,
      'title': title,
      'language': language,
      'runTime': runTime,
      'releasedDate': releasedDate,
      'genre': genre,
      'voted': voted.map((x) => x.toMap()).toList(),
      'poster': poster,
      'totalVoted': totalVoted,
      'voting': voting,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['_id'],
      description: map['description'],
      director: List<String>.from(map['director']),
      writers: List<String>.from(map['writers']),
      stars: List<String>.from(map['stars']),
      productionCompany: List<String>.from(map['productionCompany']),
      pageViews: map['pageViews']?.toInt(),
      upVoted: List<dynamic>.from(map['upVoted'] ??= []),
      downVoted: List<String>.from(map['downVoted'] ??= []),
      title: map['title'],
      language: map['language'],
      runTime: map['runTime'] ??= 0.0.toInt(),
      releasedDate: map['releasedDate'] ??= 0.0.toInt(),
      genre: map['genre'],
      voted: List<Voted>.from(map['voted']?.map((x) => Voted.fromMap(x))),
      poster: map['poster'],
      totalVoted: map['totalVoted']?.toInt(),
      voting: map['voting']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Result(id: $id, description: $description, director: $director, writers: $writers, stars: $stars, productionCompany: $productionCompany, pageViews: $pageViews, upVoted: $upVoted, downVoted: $downVoted, title: $title, language: $language, runTime: $runTime, releasedDate: $releasedDate, genre: $genre, voted: $voted, poster: $poster, totalVoted: $totalVoted, voting: $voting)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result &&
        other.id == id &&
        other.description == description &&
        listEquals(other.director, director) &&
        listEquals(other.writers, writers) &&
        listEquals(other.stars, stars) &&
        listEquals(other.productionCompany, productionCompany) &&
        other.pageViews == pageViews &&
        listEquals(other.upVoted, upVoted) &&
        listEquals(other.downVoted, downVoted) &&
        other.title == title &&
        other.language == language &&
        other.runTime == runTime &&
        other.releasedDate == releasedDate &&
        other.genre == genre &&
        listEquals(other.voted, voted) &&
        other.poster == poster &&
        other.totalVoted == totalVoted &&
        other.voting == voting;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        director.hashCode ^
        writers.hashCode ^
        stars.hashCode ^
        productionCompany.hashCode ^
        pageViews.hashCode ^
        upVoted.hashCode ^
        downVoted.hashCode ^
        title.hashCode ^
        language.hashCode ^
        runTime.hashCode ^
        releasedDate.hashCode ^
        genre.hashCode ^
        voted.hashCode ^
        poster.hashCode ^
        totalVoted.hashCode ^
        voting.hashCode;
  }
}

class Voted {
  final List<dynamic> upVoted;
  final List<dynamic> downVoted;
  final String id;
  final int updatedAt;
  final String genre;
  Voted({
    required this.upVoted,
    required this.downVoted,
    required this.id,
    required this.updatedAt,
    required this.genre,
  });

  Voted copyWith({
    List<dynamic>? upVoted,
    List<dynamic>? downVoted,
    String? id,
    int? updatedAt,
    String? genre,
  }) {
    return Voted(
      upVoted: upVoted ?? this.upVoted,
      downVoted: downVoted ?? this.downVoted,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'upVoted': upVoted,
      'downVoted': downVoted,
      '_id': id,
      'updatedAt': updatedAt,
      'genre': genre,
    };
  }

  factory Voted.fromMap(Map<String, dynamic> map) {
    return Voted(
      upVoted: List<dynamic>.from(map['upVoted']),
      downVoted: List<dynamic>.from(map['downVoted']),
      id: map['_id'],
      updatedAt: map['updatedAt']?.toInt(),
      genre: map['genre'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Voted.fromJson(String source) => Voted.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Voted(upVoted: $upVoted, downVoted: $downVoted, id: $id, updatedAt: $updatedAt, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Voted &&
        listEquals(other.upVoted, upVoted) &&
        listEquals(other.downVoted, downVoted) &&
        other.id == id &&
        other.updatedAt == updatedAt &&
        other.genre == genre;
  }

  @override
  int get hashCode {
    return upVoted.hashCode ^
        downVoted.hashCode ^
        id.hashCode ^
        updatedAt.hashCode ^
        genre.hashCode;
  }
}

class QueryParam {
  final String category;
  final String language;
  final String genre;
  final String sort;
  QueryParam({
    required this.category,
    required this.language,
    required this.genre,
    required this.sort,
  });

  QueryParam copyWith({
    String? category,
    String? language,
    String? genre,
    String? sort,
  }) {
    return QueryParam(
      category: category ?? this.category,
      language: language ?? this.language,
      genre: genre ?? this.genre,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'language': language,
      'genre': genre,
      'sort': sort,
    };
  }

  factory QueryParam.fromMap(Map<String, dynamic> map) {
    return QueryParam(
      category: map['category'] ?? '',
      language: map['language'] ?? '',
      genre: map['genre'] ?? '',
      sort: map['sort'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryParam.fromJson(String source) =>
      QueryParam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QueryParam(category: $category, language: $language, genre: $genre, sort: $sort)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QueryParam &&
        other.category == category &&
        other.language == language &&
        other.genre == genre &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        language.hashCode ^
        genre.hashCode ^
        sort.hashCode;
  }
}
