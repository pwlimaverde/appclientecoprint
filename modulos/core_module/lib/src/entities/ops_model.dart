import 'dart:convert';
import 'package:dependency_module/dependency_module.dart';

class RxOpsModel {
  final ryobi = false.obs;
  final sm2c = false.obs;
  final ryobi750 = false.obs;
  final flexo = false.obs;
  final prioridade = false.obs;
}

class OpsModel {
  int? id;
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
  DateTime? artefinal;

  final rx = RxOpsModel();

  bool get ryobi => rx.ryobi.value;
  set ryobi(bool value) => rx.ryobi.value = value;

  bool get sm2c => rx.sm2c.value;
  set sm2c(bool value) => rx.sm2c.value = value;

  bool get ryobi750 => rx.ryobi750.value;
  set ryobi750(bool value) => rx.ryobi750.value = value;

  bool get flexo => rx.flexo.value;
  set flexo(bool value) => rx.flexo.value = value;

  bool get prioridade => rx.prioridade.value;
  set prioridade(bool value) => rx.prioridade.value = value;

  OpsModel({
    this.id,
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
    this.artefinal,
    bool ryobi = false,
    bool sm2c = false,
    bool ryobi750 = false,
    bool flexo = false,
    bool prioridade = false,
  });

  OpsModel copyWith({
    int? id,
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
      id: id ?? this.id,
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
    OpsModel model = OpsModel(
      id: map['id'],
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
      artefinal:
          map['artefinal'] != null ? DateTime.parse(map['artefinal']) : null,
      prioridade: map['prioridade'],
    );
    model.ryobi = map['ryobi'] ?? false;
    model.sm2c = map['sm2c'] ?? false;
    model.ryobi750 = map['ryobi750'] ?? false;
    model.flexo = map['flexo'] ?? false;
    return model;
  }

  factory OpsModel.fromJson(String source) =>
      OpsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OpsModel(id: $id, op: $op, servico: $servico)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpsModel &&
            other.op == op &&
            other.orcamento == orcamento &&
            other.servico == servico &&
            other.cliente == cliente &&
            other.quant == quant &&
            other.vendedor == vendedor &&
            other.entrega == entrega
        // other.cancelada == cancelada &&
        // other.obs == obs &&
        // other.entrada == entrada &&
        // other.produzido == produzido &&
        // other.orderpcp == orderpcp &&
        // other.entregue == entregue &&
        // other.entregaprog == entregaprog &&
        // other.impressao == impressao &&
        // other.ryobi == ryobi &&
        // other.sm2c == sm2c &&
        // other.ryobi750 == ryobi750 &&
        // other.flexo == flexo &&
        // other.artefinal == artefinal &&
        // other.prioridade == prioridade
        ;
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
