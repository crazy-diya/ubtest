class FAQEntity {
  int? faqId;
  String? faqBody;
  String? faqHeader;
  bool isExpanded;

  FAQEntity({
    this.faqId,
    this.faqBody,
    this.faqHeader,
    this.isExpanded = false,
  });
}