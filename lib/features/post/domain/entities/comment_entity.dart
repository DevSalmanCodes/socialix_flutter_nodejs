class CommentEntity {
  final String commentId;
  final String commentedBy;
  final String comment;
  final List<String> likes;
  final DateTime timestamp;

  CommentEntity({
    required this.commentId,
    required this.commentedBy,
    required this.comment,
    required this.likes,
    required this.timestamp,
  });
}
