
class Especialista{

 String? _nome;
 String? _cargo;
 double? _salario;

 Especialista();

 Especialista.cheio( this._nome,this._cargo, this._salario);

 Especialista.fromJson(Map<String, dynamic> json){
  nome = json["nome"];
  cargo = json["cargo"];
  salario = json["salario"];
 }

 Map<String, dynamic> tojson(){
  final Map<String, dynamic> map = {};
  map["nome"]= nome;
  map["cargo"] = cargo;
  map["salario"]= salario;
  return map;
 }

 String get nome => this._nome!;
 String get cargo => this._cargo!;
 double get salario => this._salario!;

 set nome(String nome) => this._nome = nome;
 set cargo(String cargo) => this._cargo = cargo;
 set salario(double salario) => this._salario = salario;

 @override
  String toString() {
   
    return "${nome}, ${cargo}, ${salario}";
  }
}