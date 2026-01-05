// Find all the control flow nodes and their successors
// Describe how 2 control flow nodes relate using successor relationship

import cpp

from ControlFlowNode pred, ControlFlowNode succ
where pred.getASuccessor() = succ
select pred, succ
