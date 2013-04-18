package mop;
import java.io.*;
import java.lang.*;
import java.nio.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect CharSequence_NotInSetMonitorAspect implements rvmonitorrt.RVMObject {
	public CharSequence_NotInSetMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock CharSequence_NotInSet_MOPLock = new ReentrantLock();
	static Condition CharSequence_NotInSet_MOPLock_cond = CharSequence_NotInSet_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut CharSequence_NotInSet_set_addall(Collection c) : (call(* Set+.addAll(Collection)) && args(c)) && MOP_CommonPointCut();
	before (Collection c) : CharSequence_NotInSet_set_addall(c) {
		CharSequence_NotInSetRuntimeMonitor.set_addallEvent(c);
	}

	pointcut CharSequence_NotInSet_set_add() : (call(* Set+.add(..)) && args(CharSequence) && !args(String) && !args(CharBuffer)) && MOP_CommonPointCut();
	before () : CharSequence_NotInSet_set_add() {
		CharSequence_NotInSetRuntimeMonitor.set_addEvent();
	}

}
