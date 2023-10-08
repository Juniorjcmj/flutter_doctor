class Procedimento {
  dynamic id;
  String? descricao;
  dynamic valorConvenio;
  dynamic valorParticular; 
  String? convenio;
  String? classificacao;

  Procedimento({
    this.descricao,
    this.id,
    this.valorConvenio,
    this.valorParticular,    
    this.convenio,
    this.classificacao,
  });

  Procedimento.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    descricao = json["descricao"];
    valorConvenio = json["valorConvenio"];
    valorParticular = json["valorParticular"];    
    convenio = json["convenio"];
    classificacao = json["classificacao"];
  }

   @override
  String toString() {   
    return super.toString();
  }
}

