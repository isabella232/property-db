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

public aspect InputStream_ReadAheadLimitMonitorAspect implements rvmonitorrt.RVMObject {
	public InputStream_ReadAheadLimitMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock InputStream_ReadAheadLimit_MOPLock = new ReentrantLock();
	static Condition InputStream_ReadAheadLimit_MOPLock_cond = InputStream_ReadAheadLimit_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut InputStream_ReadAheadLimit_badreset(InputStream i) : (call(* InputStream+.reset(..)) && target(i) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	before (InputStream i) : InputStream_ReadAheadLimit_badreset(i) {
		//InputStream_ReadAheadLimit_goodreset
		InputStream_ReadAheadLimitRuntimeMonitor.goodresetEvent(i);
		//InputStream_ReadAheadLimit_badreset
		InputStream_ReadAheadLimitRuntimeMonitor.badresetEvent(i);
	}

	pointcut InputStream_ReadAheadLimit_mark(InputStream i, int l) : (call(* InputStream+.mark(int)) && target(i) && args(l) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	before (InputStream i, int l) : InputStream_ReadAheadLimit_mark(i, l) {
		InputStream_ReadAheadLimitRuntimeMonitor.markEvent(i, l);
	}

	pointcut InputStream_ReadAheadLimit_read_3(InputStream i) : (call(* InputStream+.read()) && target(i) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	after (InputStream i) returning (int n) : InputStream_ReadAheadLimit_read_3(i) {
		InputStream_ReadAheadLimitRuntimeMonitor.readEvent(i, n);
	}

	pointcut InputStream_ReadAheadLimit_read_4(InputStream i) : (call(* InputStream+.read(char[], ..)) && target(i) && if(i instanceof BufferedInputStream || i instanceof DataInputStream || i instanceof LineNumberInputStream)) && MOP_CommonPointCut();
	after (InputStream i) returning (int n) : InputStream_ReadAheadLimit_read_4(i) {
		InputStream_ReadAheadLimitRuntimeMonitor.readEvent(i, n);
	}

}
