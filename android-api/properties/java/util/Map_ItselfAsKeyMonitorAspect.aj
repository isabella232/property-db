package mop;
import java.util.*;
import java.lang.reflect.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Map_ItselfAsKeyMonitorAspect implements rvmonitorrt.RVMObject {
	public Map_ItselfAsKeyMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Map_ItselfAsKey_MOPLock = new ReentrantLock();
	static Condition Map_ItselfAsKey_MOPLock_cond = Map_ItselfAsKey_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Map_ItselfAsKey_putall(Map map, Map src) : (call(* Map+.putAll(Map)) && target(map) && args(src)) && MOP_CommonPointCut();
	before (Map map, Map src) : Map_ItselfAsKey_putall(map, src) {
		Map_ItselfAsKeyRuntimeMonitor.putallEvent(map, src);
	}

	pointcut Map_ItselfAsKey_put(Map map, Object key, Object value) : (call(* Map+.put(Object, Object)) && target(map) && args(key, value)) && MOP_CommonPointCut();
	before (Map map, Object key, Object value) : Map_ItselfAsKey_put(map, key, value) {
		Map_ItselfAsKeyRuntimeMonitor.putEvent(map, key, value);
	}

}
