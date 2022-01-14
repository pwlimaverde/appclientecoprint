import 'dart:convert';
import 'package:dependency_module/dependency_module.dart';

class RxOpsModel {
  final ryobi = false.obs;
  final sm2c = false.obs;
  final ryobi750 = false.obs;
  final flexo = false.obs;
  final prioridade = false.obs;
  final cancelada = false.obs;
  final orderpcp = Rxn<int>();
  final obs = Rxn<String>();
  final artefinal = Rxn<DateTime>();
  final produzido = Rxn<DateTime>();
  final entregue = Rxn<DateTime>();
  final entregaprog = Rxn<DateTime>();
  final impressao = Rxn<DateTime>();
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
  DateTime entrega;

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

  bool get cancelada => rx.cancelada.value;
  set cancelada(bool value) => rx.cancelada.value = value;

  int? get orderpcp => rx.orderpcp.value;
  set orderpcp(int? value) => rx.orderpcp.value = value;

  String? get obs => rx.obs.value;
  set obs(String? value) => rx.obs.value = value;

  DateTime? get artefinal => rx.artefinal.value;
  set artefinal(DateTime? value) => rx.artefinal.value = value;

  DateTime? get produzido => rx.produzido.value;
  set produzido(DateTime? value) => rx.produzido.value = value;

  DateTime? get entregue => rx.entregue.value;
  set entregue(DateTime? value) => rx.entregue.value = value;

  DateTime? get entregaprog => rx.entregaprog.value;
  set entregaprog(DateTime? value) => rx.entregaprog.value = value;

  DateTime? get impressao => rx.impressao.value;
  set impressao(DateTime? value) => rx.impressao.value = value;

  OpsModel({
    this.id,
    required this.op,
    required this.orcamento,
    required this.servico,
    required this.cliente,
    required this.quant,
    required this.vendedor,
    required this.entrada,
    required this.entrega,
  });

  factory OpsModel.fromMap(Map<String, dynamic> map) {
    OpsModel model = OpsModel(
      id: map['id'],
      op: map['op'],
      orcamento: map['orcamento'],
      servico: map['servico'],
      cliente: map['cliente'],
      quant: map['quant'],
      vendedor: map['vendedor'],
      entrada: DateTime.parse(map['entrada']),
      entrega: DateTime.parse(map['entrega']),
    );
    model.ryobi = map['ryobi'] ?? false;
    model.sm2c = map['sm2c'] ?? false;
    model.ryobi750 = map['ryobi750'] ?? false;
    model.flexo = map['flexo'] ?? false;
    model.prioridade = map['prioridade'] ?? false;
    model.cancelada = map['cancelada'];
    model.obs = map['obs'];
    model.orderpcp = map['orderpcp'];
    model.artefinal =
        map['artefinal'] != null ? DateTime.parse(map['artefinal']) : null;
    model.produzido =
        map['produzido'] != null ? DateTime.parse(map['produzido']) : null;
    model.entregue =
        map['entregue'] != null ? DateTime.parse(map['entregue']) : null;
    model.entregaprog =
        map['entregaprog'] != null ? DateTime.parse(map['entregaprog']) : null;
    model.impressao =
        map['impressao'] != null ? DateTime.parse(map['impressao']) : null;
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
