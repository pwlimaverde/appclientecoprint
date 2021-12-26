const String opsAllQuery = """
subscription{
  ops(order_by: {op: desc}){
    op 
    servico  
    cancelada 
    cliente 
    obs 
    quant 
    vendedor
    entrada 
    produzido
    entrega
    entregue
    entregaprog
    impressao
    ryobi
    sm2c
    ryobi750
    flexo
    artefinal
    orderpcp
    prioridade
  }
}
""";

const String opsAllQuery2 = """
query{
  ops(order_by: {op: desc}){
    op 
    servico  
    cancelada 
    cliente 
    obs 
    quant 
    vendedor
    entrada 
    produzido
    entrega
    entregue
    entregaprog
    impressao
    ryobi
    sm2c
    ryobi750
    flexo
    artefinal
    orderpcp
  }
}
""";

const String opsCanMutation = """
mutation CanOps(\$op: Int, \$cancelada: Boolean) {
  update_ops(where: {op: {_eq: \$op}}, _set: {cancelada: \$cancelada}) {
    affected_rows
  }
}
""";

const String opsPrioridadeMutation = """
mutation CanOps(\$op: Int, \$prioridade: Boolean) {
  update_ops(where: {op: {_eq: \$op}}, _set: {prioridade: \$prioridade}) {
    affected_rows
  }
}
""";

const String opsArteFinalMutation = """
mutation ProdOps(\$op: Int, \$artefinal: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {artefinal: \$artefinal}) {
    affected_rows
  }
}
""";

const String opsProdMutation = """
mutation ProdOps(\$op: Int, \$produzido: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {produzido: \$produzido}) {
    affected_rows
  }
}
""";

const String opsEntMutation = """
mutation EntOps(\$op: Int, \$entregue: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {entregue: \$entregue}) {
    affected_rows
  }
}
""";

const String opsCan = """
query (\$op: Int) {
  ops(where: {op: {_eq: \$op}}) {
    cancelada
  }
}
""";

const String opsInfoMutation = """
mutation InfoOps(\$op: Int, \$entrega: date, \$entregaprog: date, \$obs: String, \$ryobi: Boolean, \$sm2c: Boolean, \$ryobi750: Boolean, \$flexo: Boolean, \$impressao: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {entrega: \$entrega, entregaprog: \$entregaprog, obs: \$obs, ryobi: \$ryobi, sm2c: \$sm2c, ryobi750: \$ryobi750, flexo: \$flexo, impressao: \$impressao}) {
    affected_rows
  }
}
""";

//const String opsQuery = """
//query{ops{op servico acabamento acm cancelada cliente coa colagem com corte cva cvm1 cvm2 entrada entrega entregue flexo id impressao lam1 laminacao obs orcamento produzido quant ryobi sm2c ryobi750 valor vendedor}}
//""";
