import 'package:store/src/models/Product.dart';
import 'package:store/src/utils/CategoryConverter.dart';

Product ProductDataConversion(item){
  List<dynamic> originalImageURLS = item['images'];
  List<String> correctedImageURLS = [];
  for (int i=0; i<originalImageURLS.length; i++){
    int startIndex = originalImageURLS[i].indexOf('http');
    int endIndex = 0;

    originalImageURLS[i].contains('jpeg')
      ? endIndex = originalImageURLS[i].lastIndexOf('jpeg') + 4
      : endIndex = originalImageURLS[i].lastIndexOf('jpgg') + 3;
    

    correctedImageURLS.add(originalImageURLS[i].substring(startIndex,endIndex));
    
  }


  Product product = Product(
    id: item['id'],
    title: item['title'],
    price: item['price'],
    description: item['description'],
    images: correctedImageURLS,
    category: CategoryDataConversion(item['category']));
    return product;
}