/**
 * @id cpp/control-flow-graph
 * @kind path-problem
 */
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
  // Entry node: no predecessors
  not exists(ControlFlowNode pred | pred.getASuccessor() = source) and
  // Intra-procedural: same function
  source.getControlFlowScope() = destination.getControlFlowScope() and
  // Optional: only show paths to exit nodes for cleaner output
  // not exists(destination.getASuccessor())
select source, source, destination, "Control flow from entry at $@", source, source.toString()
