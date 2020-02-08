class BudModel{
  final String id;
  final String budget;


  BudModel( {this.id,this.budget});

  BudModel.fromMap(Map<String , dynamic> data, String id):
  budget=data['budget'],
  id=id;


  Map<String , dynamic>toMap(){
    return{
      "budget":budget,
    };
  }


}