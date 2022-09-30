class FirestorePath {
  static String users = 'users';
  static String user(String id) => 'users/$id';
  static String categories = 'category';
  static String category(String id) => 'category/$id';
  static String subCategories = 'sub_category';
  static String subCategory(String id) => 'sub_category/$id';
  static String brands = 'brand';
  static String brand(String id) => 'brand/$id';
  static String fabrics = 'fabric';
  static String fabric(String id) => 'fabric/$id';
  static String favorites(String uid, String productId) => 'favorites/$uid';
}

enum FirestoreOperationType {
  user,
  category,
  subCategory,
  brand,
  fabric,
  favorites
}
