import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
  static var db, userCollection;
  static connect() async{
    db = await Db.create("mongodb+srv://TeamSOS:IshanBEST@fid.f8e3plo.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    userCollection = db.collection("test");
  }
}