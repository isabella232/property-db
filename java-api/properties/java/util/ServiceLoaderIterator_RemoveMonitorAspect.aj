package mop;
import java.util.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect ServiceLoaderIterator_RemoveMonitorAspect implements rvmonitorrt.RVMObject {
	public ServiceLoaderIterator_RemoveMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock ServiceLoaderIterator_Remove_MOPLock = new ReentrantLock();
	static Condition ServiceLoaderIterator_Remove_MOPLock_cond = ServiceLoaderIterator_Remove_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut ServiceLoaderIterator_Remove_remove(Iterator i) : (call(* Iterator+.remove(..)) && target(i)) && MOP_CommonPointCut();
	before (Iterator i) : ServiceLoaderIterator_Remove_remove(i) {
		ServiceLoaderIterator_RemoveRuntimeMonitor.removeEvent(i);
	}

	pointcut ServiceLoaderIterator_Remove_create(ServiceLoader s) : (call(Iterator ServiceLoader.iterator()) && target(s)) && MOP_CommonPointCut();
	after (ServiceLoader s) returning (Iterator i) : ServiceLoaderIterator_Remove_create(s) {
		ServiceLoaderIterator_RemoveRuntimeMonitor.createEvent(s, i);
	}

}
