import 'dart:collection';

HashMap<int, String> filterCategory(productList) {
  HashMap<int, String> filteredData = HashMap();
  for (int i = 0; i < 1; i++) {
    String catName = productList[i]['category']['name'];
    int catId = productList[i]['category']['id'];
    if (!filteredData.containsKey(catId)) {
      filteredData[catId] = catName;
    }
  }
  return filteredData;
}
