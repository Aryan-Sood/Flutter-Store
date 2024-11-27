import 'package:store/src/models/Category.dart';

Category CategoryDataConversion(item) {
  Category category =
      Category(id: item['id'], name: item['name'], image: item['image']);

  return category;
}
