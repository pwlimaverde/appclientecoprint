const String opsArteFinalSubscription = """
subscription{
  ops(order_by: {op: desc}, where: {cancelada: {_eq: false}, produzido: {_is_null: true}, entregue: {_is_null: true}, artefinal: {_is_null: true},}){
    id
    op
    orcamento 
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

const String opsProducaoSubscription = """
subscription{
  ops(order_by: {op: desc}, where: {cancelada: {_eq: false}, produzido: {_is_null: true}, entregue: {_is_null: true}, artefinal: {_is_null: false},}){
    id
    op
    orcamento 
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

const String opsExpedicaoSubscription = """
subscription{
  ops(order_by: {op: desc}, where: {cancelada: {_eq: false}, produzido: {_is_null: false}, entregue: {_is_null: true},}){
    id
    op
    orcamento 
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

const String opsAllSubscription = """
subscription{
  ops(order_by: {op: desc}){
    id
    op
    orcamento 
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

const String opsAllQuery = """
query{
  ops(order_by: {op: desc}){
    id
    op
    orcamento 
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
mutation CanOps(\$op: Int, \$orderpcp : Int, \$prioridade: Boolean) {
  update_ops(where: {op: {_eq: \$op}}, _set: {orderpcp: \$orderpcp, prioridade: \$prioridade}) {
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

const String opsInfoMutation = """
mutation InfoOps(\$op: Int, \$orderpcp : Int, \$entrega: date, \$entregaprog: date, \$entregue: date, \$produzido: date, \$artefinal: date, \$obs: String, \$ryobi: Boolean, \$sm2c: Boolean, \$ryobi750: Boolean, \$flexo: Boolean, \$impressao: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {orderpcp: \$orderpcp, entrega: \$entrega, entregaprog: \$entregaprog, entregue: \$entregue, produzido: \$produzido, artefinal: \$artefinal, obs: \$obs, ryobi: \$ryobi, sm2c: \$sm2c, ryobi750: \$ryobi750, flexo: \$flexo, impressao: \$impressao}) {
    affected_rows
  }
}
""";

const String opsRyobiMutation = """
mutation InfoOps(\$op: Int, \$ryobi: Boolean,) {
  update_ops(where: {op: {_eq: \$op}}, _set: {ryobi: \$ryobi}) {
    affected_rows
  }
}
""";

const String opsUpdateMutation = """
mutation InfoOps(\$op: Int, \$servico: String, \$cliente: String, \$quant : Int, \$vendedor: String, \$entrega: date) {
  update_ops(where: {op: {_eq: \$op}}, _set: {servico: \$servico, cliente: \$cliente, quant: \$quant, vendedor: \$vendedor, entrega: \$entrega}) {
    affected_rows
  }
}
""";

const String uploadOpsMutation = """
mutation InsertOps(\$cliente: String, \$op: Int, \$orcamento: Int, \$quant: Int, \$servico: String, \$vendedor: String, \$entrega: date, \$entrada: date) {
  insert_ops(objects: {cliente: \$cliente, op: \$op, orcamento: \$orcamento, quant: \$quant, servico: \$servico, vendedor: \$vendedor, entrega: \$entrega, entrada: \$entrada}) {
    affected_rows
  }
}
""";
