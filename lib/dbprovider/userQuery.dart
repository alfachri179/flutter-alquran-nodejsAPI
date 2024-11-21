class UserQuery {
  static const String TABLE_NAME = "data";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , lastRead TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
