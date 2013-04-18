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

public aspect Arrays_MutuallyComparableMonitorAspect implements rvmonitorrt.RVMObject {
	public Arrays_MutuallyComparableMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Arrays_MutuallyComparable_MOPLock = new ReentrantLock();
	static Condition Arrays_MutuallyComparable_MOPLock_cond = Arrays_MutuallyComparable_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Arrays_MutuallyComparable_invalid_sort(Object[] arr, Comparator comp) : ((call(void Arrays.sort(Object[], Comparator)) || call(void Arrays.sort(Object[], int, int, Comparator))) && args(arr, .., comp)) && MOP_CommonPointCut();
	before (Object[] arr, Comparator comp) : Arrays_MutuallyComparable_invalid_sort(arr, comp) {
		Arrays_MutuallyComparableRuntimeMonitor.invalid_sortEvent(arr, comp);
	}

}
