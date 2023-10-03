class Especialista {
  int? id;
  String? nome;
  String? cro;
  String? especialidade;
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
 

   Especialista.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nome = json["nome"];
    cro = json["cro"];
    especialidade = json["especialidade"];
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
    
  }
  Especialista();

  Especialista.cheio(
      this.id,
      this.nome,
      this.especialidade,
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
     );     


   @override
  String toString() {   
    return super.toString();
  }
 
}
