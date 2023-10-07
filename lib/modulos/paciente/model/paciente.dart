class Paciente {
  int? id;
  String? nome;
  String? convenio;
  String? genero;
  String? cpf;
  int? idade;
  String? email;
  String? senha;
  String? celular;
  String? whatsapp;
  bool? ativo;
  String? rua;
  String? bairro;
  String? cidade;
  String? uf;
  String? cep;
  String? dataCriacao;
  String? dataAtualizacao;
  String? cor;
  String? carteirinha;

   Paciente.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nome = json["nome"];
    convenio = json["convenio"];
    cpf = json["cpf"];
    idade = json["idade"];
    email = json["email"];
    senha = json["senha"];
    celular = json["celular"];
    whatsapp = json["whatsapp"];
    ativo = json["ativo"];
    rua = json["rua"];
    bairro = json["bairro"];
    cidade = json["cidade"];
    uf = json["uf"];
    cep = json["cep"];
    dataCriacao = json["dataCriacao"];
    dataAtualizacao = json["dataAtualizacao"];
    cor = json["cor"];
    carteirinha = json["carteirinha"];
     genero = json["genero"];
  }
 Paciente(){}
  Paciente.cheio(
      this.id,
      this.nome,
      this.genero,
      this.convenio,
      this.cpf,
      this.idade,
      this.email,
      this.senha,
      this.celular,
      this.whatsapp,
      this.ativo,
      this.rua,
      this.bairro,
      this.cidade,
      this.uf,
      this.cep,
      this.dataCriacao,
      this.dataAtualizacao,
      this.cor,
      this.carteirinha);     


   @override
  String toString() {   
    return super.toString();
  }
 
}
