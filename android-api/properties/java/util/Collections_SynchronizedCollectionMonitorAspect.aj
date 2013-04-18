package mop;
import java.util.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Collections_SynchronizedCollectionMonitorAspect implements rvmonitorrt.RVMObject {
	public Collections_SynchronizedCollectionMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Collections_SynchronizedCollection_MOPLock = new ReentrantLock();
	static Condition Collections_SynchronizedCollection_MOPLock_cond = Collections_SynchronizedCollection_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Collections_SynchronizedCollection_accessIter(Iterator iter) : (call(* Iterator.*(..)) && target(iter)) && MOP_CommonPointCut();
	before (Iterator iter) : Collections_SynchronizedCollection_accessIter(iter) {
		Collections_SynchronizedCollectionRuntimeMonitor.accessIterEvent(iter);
	}

	pointcut Collections_SynchronizedCollection_sync() : (call(* Collections.synchronizedCollection(Collection)) || call(* Collections.synchronizedSet(Set)) || call(* Collections.synchronizedSortedSet(SortedSet)) || call(* Collections.synchronizedList(List))) && MOP_CommonPointCut();
	after () returning (Collection col) : Collections_SynchronizedCollection_sync() {
		Collections_SynchronizedCollectionRuntimeMonitor.syncEvent(col);
	}

	pointcut Collections_SynchronizedCollection_syncCreateIter(Collection col) : (call(* Collection+.iterator()) && target(col)) && MOP_CommonPointCut();
	after (Collection col) returning (Iterator iter) : Collections_SynchronizedCollection_syncCreateIter(col) {
		//Collections_SynchronizedCollection_syncCreateIter
		Collections_SynchronizedCollectionRuntimeMonitor.syncCreateIterEvent(col, iter);
		//Collections_SynchronizedCollection_asyncCreateIter
		Collections_SynchronizedCollectionRuntimeMonitor.asyncCreateIterEvent(col, iter);
	}

}
