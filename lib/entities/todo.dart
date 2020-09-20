
class Todo{
  String title;
  bool isDone;

  Todo(this.title, this.isDone);

  static const String createQuery = 'CREATE TABLE todo (title TEXT PRIMARY KEY, isDone INTEGER)';

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}