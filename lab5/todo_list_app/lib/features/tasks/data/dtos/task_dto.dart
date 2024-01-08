class TaskDto {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  TaskDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
