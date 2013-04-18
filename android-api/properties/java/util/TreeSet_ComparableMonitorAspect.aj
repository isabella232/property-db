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

public aspect TreeSet_ComparableMonitorAspect implements rvmonitorrt.RVMObject {
	public TreeSet_ComparableMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock TreeSet_Comparable_MOPLock = new ReentrantLock();
	static Condition TreeSet_Comparable_MOPLock_cond = TreeSet_Comparable_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut TreeSet_Comparable_addall(Collection c) : (call(* Collection+.addAll(Collection)) && target(TreeSet) && args(c)) && MOP_CommonPointCut();
	before (Collection c) : TreeSet_Comparable_addall(c) {
		TreeSet_ComparableRuntimeMonitor.addallEvent(c);
	}

	pointcut TreeSet_Comparable_add(Object e) : (call(* Collection+.add*(..)) && target(TreeSet) && args(e)) && MOP_CommonPointCut();
	before (Object e) : TreeSet_Comparable_add(e) {
		TreeSet_ComparableRuntimeMonitor.addEvent(e);
	}

}
