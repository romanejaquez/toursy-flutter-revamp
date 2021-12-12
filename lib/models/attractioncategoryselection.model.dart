class AttractionCategorySelection {
  String? selectedLabel;
  AttractionCategory? selectedCategory;
  String? selectedId;

  AttractionCategorySelection({
    this.selectedCategory,
    this.selectedLabel,
    this.selectedId
  });
}

enum AttractionCategory {
  byRegion,
  byActivity
}