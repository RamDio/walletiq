class BrModel{
  final String id;
  final String brname;
  final String bramount;
  final String brdate;
  final String brtype;


  BrModel( {this.id,this.brname,this.bramount,this.brdate,this.brtype});

  BrModel.fromMap(Map<String , dynamic> data, String id):
  brname=data['brname'],
  bramount=data['bramount'],
  brdate=data['brdate'],
  brtype=data['brtype'],
  id=id;


  Map<String , dynamic>toMap(){
    return{
      "brname":brname,
      "bramount":bramount,
      "brdate":brdate,
      "brtype":brtype,
    };
  }


}