class CategoryModel{
  int id;
  String name;
  CategoryModel({required this.id,required this.name});
  factory CategoryModel.fromJSON(data){
    return CategoryModel(
        id: data["id"],
        name: data["name"]
    );
  }
}