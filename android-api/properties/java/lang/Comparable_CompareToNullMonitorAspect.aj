package mop;
import java.io.*;
import java.lang.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Comparable_CompareToNullMonitorAspect implements rvmonitorrt.RVMObject {
	public Comparable_CompareToNullMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Comparable_CompareToNull_MOPLock = new ReentrantLock();
	static Condition Comparable_CompareToNull_MOPLock_cond = Comparable_CompareToNull_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Comparable_CompareToNull_nullcompare(Object o) : (call(* Comparable+.compareTo(..)) && args(o) && if(o == null)) && MOP_CommonPointCut();
	before (Object o) : Comparable_CompareToNull_nullcompare(o) {
		Comparable_CompareToNullRuntimeMonitor.nullcompareEvent(o);
	}

}
