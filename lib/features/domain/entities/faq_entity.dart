// ignore_for_file: public_member_api_docs, sort_constructors_first
class FAQEntity {
  int faqId;
  String faqBody;
  String faqHeader;
  bool isExpanded;

  FAQEntity({
    required this.faqId,
    required this.faqBody,
    required this.faqHeader,
    this.isExpanded = false,
  });

  @override
  String toString() {
    return 'FAQEntity(faqId: $faqId, faqBody: $faqBody, faqHeader: $faqHeader, isExpanded: $isExpanded)';
  }
}
