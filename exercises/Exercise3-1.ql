/**
 * @id cpp/control-flow-graph
 * @kind path-problem
 */

// Answers the question: "Show me all nodes in each function's CFG"

import cpp

query predicate edges(ControlFlowNode pred, ControlFlowNode succ) { 
    pred.getASuccessor() = succ 
}

query predicate nodes(ControlFlowNode n, string key, string val) {
  key = "semmle.label" and
  val = n.toString() + " : " + n.getAPrimaryQlClass()
}

predicate reachable(ControlFlowNode source, ControlFlowNode destination) {
  destination = source.getASuccessor+()
}

from ControlFlowNode source, ControlFlowNode destination
where
  reachable(source, destination) and
  source != destination and
  // Entry nodes have no predecessors
  not exists(ControlFlowNode pred | pred.getASuccessor() = source) and
  // Stay within same function
  source.getControlFlowScope() = destination.getControlFlowScope()
select source, source, destination, "Control flow starting at $@", source, source.toString()
