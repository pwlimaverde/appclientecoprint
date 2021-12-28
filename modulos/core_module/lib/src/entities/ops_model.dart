import 'dart:convert';

class OpsModel {
  final int op;
  final int orcamento;
  final String servico;
  final String cliente;
  final int quant;
  final String vendedor;
  final DateTime entrada;
  bool cancelada;
  DateTime entrega;
  int? orderpcp;
  String? obs;
  DateTime? produzido;
  DateTime? entregue;
  DateTime? entregaprog;
  DateTime? impressao;
  bool? ryobi;
  bool? sm2c;
  bool? ryobi750;
  bool? flexo;
  DateTime? artefinal;
  bool? prioridade;
  OpsModel({
    required this.op,
    required this.orcamento,
    required this.servico,
    required this.cliente,
    required this.quant,
    required this.vendedor,
    required this.entrada,
    required this.cancelada,
    required this.entrega,
    this.orderpcp,
    this.obs,
    this.produzido,
    this.entregue,
    this.entregaprog,
    this.impressao,
    this.ryobi,
    this.sm2c,
    this.ryobi750,
    this.flexo,
    this.artefinal,
    this.prioridade,
  });

  OpsModel copyWith({
    int? op,
    int? orcamento,
    String? servico,
    bool? cancelada,
    String? cliente,
    String? obs,
    int? quant,
    String? vendedor,
    DateTime? entrada,
    DateTime? produzido,
    DateTime? entrega,
    int? orderpcp,
    DateTime? entregue,
    DateTime? entregaprog,
    DateTime? impressao,
    bool? ryobi,
    bool? sm2c,
    bool? ryobi750,
    bool? flexo,
    DateTime? artefinal,
    bool? prioridade,
  }) {
    return OpsModel(
      op: op ?? this.op,
      orcamento: orcamento ?? this.orcamento,
      servico: servico ?? this.servico,
      cancelada: cancelada ?? this.cancelada,
      cliente: cliente ?? this.cliente,
      obs: obs ?? this.obs,
      quant: quant ?? this.quant,
      vendedor: vendedor ?? this.vendedor,
      entrada: entrada ?? this.entrada,
      produzido: produzido ?? this.produzido,
      entrega: entrega ?? this.entrega,
      orderpcp: orderpcp ?? this.orderpcp,
      entregue: entregue ?? this.entregue,
      entregaprog: entregaprog ?? this.entregaprog,
      impressao: impressao ?? this.impressao,
      ryobi: ryobi ?? this.ryobi,
      sm2c: sm2c ?? this.sm2c,
      ryobi750: ryobi750 ?? this.ryobi750,
      flexo: flexo ?? this.flexo,
      artefinal: artefinal ?? this.artefinal,
      prioridade: prioridade ?? this.prioridade,
    );
  }

  factory OpsModel.fromMap(Map<String, dynamic> map) {
    return OpsModel(
      op: map['op'],
      orcamento: map['orcamento'],
      servico: map['servico'],
      cancelada: map['cancelada'],
      cliente: map['cliente'],
      obs: map['obs'],
      quant: map['quant'],
      vendedor: map['vendedor'],
      entrada: DateTime.parse(map['entrada']),
      produzido:
          map['produzido'] != null ? DateTime.parse(map['produzido']) : null,
      entrega: DateTime.parse(map['entrega']),
      orderpcp: map['orderpcp'],
      entregue:
          map['entregue'] != null ? DateTime.parse(map['entregue']) : null,
      entregaprog: map['entregaprog'] != null
          ? DateTime.parse(map['entregaprog'])
          : null,
      impressao:
          map['impressao'] != null ? DateTime.parse(map['impressao']) : null,
      ryobi: map['ryobi'],
      sm2c: map['sm2c'],
      ryobi750: map['ryobi750'],
      flexo: map['flexo'],
      artefinal:
          map['artefinal'] != null ? DateTime.parse(map['artefinal']) : null,
      prioridade: map['prioridade'],
    );
  }

  factory OpsModel.fromJson(String source) =>
      OpsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OpsModel(op: $op, servico: $servico)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpsModel &&
        other.op == op &&
        other.orcamento == orcamento &&
        other.servico == servico &&
        other.cancelada == cancelada &&
        other.cliente == cliente &&
        other.obs == obs &&
        other.quant == quant &&
        other.vendedor == vendedor &&
        other.entrada == entrada &&
        other.produzido == produzido &&
        other.entrega == entrega &&
        other.orderpcp == orderpcp &&
        other.entregue == entregue &&
        other.entregaprog == entregaprog &&
        other.impressao == impressao &&
        other.ryobi == ryobi &&
        other.sm2c == sm2c &&
        other.ryobi750 == ryobi750 &&
        other.flexo == flexo &&
        other.artefinal == artefinal &&
        other.prioridade == prioridade;
  }

  @override
  int get hashCode {
    return op.hashCode ^
        orcamento.hashCode ^
        servico.hashCode ^
        cancelada.hashCode ^
        cliente.hashCode ^
        obs.hashCode ^
        quant.hashCode ^
        vendedor.hashCode ^
        entrada.hashCode ^
        produzido.hashCode ^
        entrega.hashCode ^
        orderpcp.hashCode ^
        entregue.hashCode ^
        entregaprog.hashCode ^
        impressao.hashCode ^
        ryobi.hashCode ^
        sm2c.hashCode ^
        ryobi750.hashCode ^
        flexo.hashCode ^
        artefinal.hashCode ^
        prioridade.hashCode;
  }
}
