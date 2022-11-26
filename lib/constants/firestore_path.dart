class FirestorePath {
  static String users = 'users';
  static String user(int id) => 'users/$id';
  static String categories = 'category';
  static String category(int id) => 'category/$id';
  static String subCategories = 'sub_category';
  static String subCategory(int id) => 'sub_category/$id';
  static String brands = 'brand';
  static String brand(int id) => 'brand/$id';
  static String fabrics = 'fabric';
  static String fabric(int id) => 'fabric/$id';
  static String products = 'product';
  static String product(int id) => 'product/$id';
  static String favorites(String uid, int productId) => 'favorites/$uid';
  static String testimonials = 'testimonial';
  static String testimonial(int id) => 'testimonial/$id';
}

enum FirestoreOperationType {
  user,
  category,
  subCategory,
  brand,
  fabric,
  favorites,
  testimonial,
  product,
}
