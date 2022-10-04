enum PreviewPattern {
  none(title: "なし"),
  image(title: "画像"),
  doted(title: "ドット絵"),
  ;

  final String title;
  const PreviewPattern({required this.title});
}
