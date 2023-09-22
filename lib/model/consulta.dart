
class Consulta {
  String? id;
  String? _start;
  String? _end;
  String? _valor;
  String? _tipo;
  String? _confirmado;
  String? _ausencia;
  String? _observacao;
  String? _dataCriacao;
  String? _dataAtualizacao;
  String? _status;
  String? _formaPagamento;
  String? _pacienteId;
  String? _dentistaId;
  String? _nomeDentista;
  String? _nomePaciente;
  String? _corDentista;
  String? _corPaciente;  

  Consulta();
  Consulta.pacienteVazio(String nomePaciente){
     _nomePaciente = '';
  }

  Consulta.cheio(
     this.id,
      this._start,
      this._end,
      this._valor,
      this._tipo,
      this._confirmado,
      this._ausencia,
      this._observacao,
      this._dataCriacao,
      this._dataAtualizacao,
      this._status,
      this._formaPagamento,
      this._pacienteId,
      this._dentistaId,
      this._nomeDentista,
      this._nomePaciente,
      this._corDentista,
      this._corPaciente);

  Consulta.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    start = json["start"];
    end = json["end"];
    valor = json["valor"];
    tipo = json["tipo"];
    confirmado = json["confirmado"];
    ausencia = json["ausencia"];
    observacao = json["observacao"];
    dataCriacao = json["dataCriacao"];
    dataAtualizacao = json["dataAtualizacao"];
    status = json["status"];
    formaPagamento = json["formaPagamento"];
    pacienteId = json["pacienteId"];
    dentistaId = json["dentistaId"];
    nomeDentista = json["nomeDentista"];
    nomePaciente = json["nomePaciente"];
    corDentista = json["corDentista"];
    corPaciente = json["corPaciente"];
  }
  
  String get start => _start!;
  String get end => _end!;
  String get valor => _valor!;
  String get tipo => _tipo!;
  String get confirmado => _confirmado!;
  String get ausencia => _ausencia!;
  String get observacao => _observacao!;
  String get dataCriacao => _dataCriacao!;
  String get dataAtualizacao => _dataAtualizacao!;
  String get status => _status!;
  String get formaPagamento => _formaPagamento!;
  String get pacienteId => _pacienteId!;
  String get dentistaId => _dentistaId!;
  String get nomeDentista => _nomeDentista!;
  String get nomePaciente => _nomePaciente!;
  String get corDentista => _corDentista!;
  String get corPaciente => _corPaciente!;

  
  set start(String start) => _start = start;
  set end(String end) => _end = end;
  set tipo(String tipo) => _tipo = tipo;
  set valor(String valor) => _valor = valor;
  set confirmado(String confirmado) => _confirmado = confirmado;
  set ausencia(String ausencia) => _ausencia = ausencia;
  set observacao(String observacao) => _observacao = observacao;
  set dataCriacao(String dataCriacao) => _dataCriacao = dataCriacao;
  set dataAtualizacao(String dataAtualizacao) =>
      _dataAtualizacao = dataAtualizacao;
  set status(String status) => _status = status;
  set formaPagamento(String formaPagamento) =>
      _formaPagamento = formaPagamento;
  set pacienteId(String pacienteId) => _pacienteId = pacienteId;
  set dentistaId(String dentistaId) => _dentistaId = dentistaId;
  set nomeDentista(String nomeDentista) => _nomeDentista = nomeDentista;
  set nomePaciente(String nomePaciente) => _nomePaciente = nomePaciente;
  set corDentista(String corDentista) => _corDentista = corDentista;
  set corPaciente(String corPaciente) => _corPaciente = corPaciente;

  // @override
  // String toString() {
  //   return "$id, $start, $end,$tipo, $valor, $confirmado,"+
  //   "$ausencia, $observacao, $dataCriacao,$dataAtualizacao, $status, $formaPagamento,$pacienteId, $dentistaId, $nomeDentista,$nomePaciente, $corDentista, $corPaciente";
  // }

}
