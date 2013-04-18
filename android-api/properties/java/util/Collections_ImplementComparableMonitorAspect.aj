package mop;
import java.util.*;
import java.lang.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Collections_ImplementComparableMonitorAspect implements rvmonitorrt.RVMObject {
	public Collections_ImplementComparableMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Collections_ImplementComparable_MOPLock = new ReentrantLock();
	static Condition Collections_ImplementComparable_MOPLock_cond = Collections_ImplementComparable_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Collections_ImplementComparable_invalid_minmax(Collection col) : ((call(* Collections.min(Collection)) || call(* Collections.max(Collection))) && args(col)) && MOP_CommonPointCut();
	before (Collection col) : Collections_ImplementComparable_invalid_minmax(col) {
		Collections_ImplementComparableRuntimeMonitor.invalid_minmaxEvent(col);
	}

	pointcut Collections_ImplementComparable_invalid_sort(List list) : (call(void Collections.sort(List)) && args(list)) && MOP_CommonPointCut();
	before (List list) : Collections_ImplementComparable_invalid_sort(list) {
		Collections_ImplementComparableRuntimeMonitor.invalid_sortEvent(list);
	}

}
