class BookDto {
  const BookDto({
    this.id,
    this.title,
    this.author,
    this.coverImageUrl,
  });

  final String? id;
  final String? title;
  final String? author;
  final String? coverImageUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'coverImageUrl': coverImageUrl,
    };
  }

  factory BookDto.fromJson(Map<String, dynamic> json) {
    final String? id =
        (json['title'] as String?) == null ||
            (json['author'] as String?) == null
        ? null
        : json['title'] + json['author'];

    return BookDto(
      id: id,
      title: json['title'] as String?,
      author: json['author'] as String?,
      coverImageUrl: json['cover_image'] as String?,
    );
  }

  BookDto copyWith({
    String? id,
    String? title,
    String? author,
    String? coverImageUrl,
  }) {
    return BookDto(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
    );
  }
}
