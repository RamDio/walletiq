class ExpModel{
  final String id;
  final String expname;
  final String expamount;
  final String expdate;
  final String exptype;


  ExpModel( {this.id,this.expname,this.expamount,this.expdate,this.exptype});

  ExpModel.fromMap(Map<String , dynamic> data, String id):
  expname=data['expname'],
  expamount=data['expamount'],
  expdate=data['expdate'],
  exptype=data['exptype'],
  id=id;


  Map<String , dynamic>toMap(){
    return{
      "expname":expname,
      "expamount":expamount,
      "expdate":expdate,
      "exptype":exptype,
    };
  }


}