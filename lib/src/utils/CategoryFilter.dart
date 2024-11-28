import 'dart:collection';

HashMap<int, String> filterCategory(items) {
  HashMap<int, String> filteredData = HashMap();

  for (int i = 0; i < items.length; i++) {
    final int catId = items[i]['category']['id'];
    final String catName = items[i]['category']['name'];
    if (!filteredData.containsKey(catId)) {
      filteredData[catId] = catName;
    }
  }

  return filteredData;
}
