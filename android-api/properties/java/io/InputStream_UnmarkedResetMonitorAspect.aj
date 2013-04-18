package mop;
import java.io.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect InputStream_UnmarkedResetMonitorAspect implements rvmonitorrt.RVMObject {
	public InputStream_UnmarkedResetMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock InputStream_UnmarkedReset_MOPLock = new ReentrantLock();
	static Condition InputStream_UnmarkedReset_MOPLock_cond = InputStream_UnmarkedReset_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut InputStream_UnmarkedReset_reset(InputStream i) : (call(* InputStream+.reset(..)) && target(i) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	before (InputStream i) : InputStream_UnmarkedReset_reset(i) {
		InputStream_UnmarkedResetRuntimeMonitor.resetEvent(i);
	}

	pointcut InputStream_UnmarkedReset_mark(InputStream i) : (call(* InputStream+.mark(..)) && target(i) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	before (InputStream i) : InputStream_UnmarkedReset_mark(i) {
		InputStream_UnmarkedResetRuntimeMonitor.markEvent(i);
	}

}
