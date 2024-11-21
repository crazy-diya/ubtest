// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComposeMailResult {
bool result;
String message;
WHERE where;
  ComposeMailResult({
    required this.result,
    required this.message,
    required this.where,
  });

  @override
  String toString() => 'ComposeMailResult(result: $result, message: $message, where: $where)';
}

enum WHERE {
  REPLY,
  NEW,
  NONE,
  DRAFT
}
