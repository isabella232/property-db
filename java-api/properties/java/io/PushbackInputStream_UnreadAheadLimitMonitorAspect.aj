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

public aspect PushbackInputStream_UnreadAheadLimitMonitorAspect implements rvmonitorrt.RVMObject {
	public PushbackInputStream_UnreadAheadLimitMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock PushbackInputStream_UnreadAheadLimit_MOPLock = new ReentrantLock();
	static Condition PushbackInputStream_UnreadAheadLimit_MOPLock_cond = PushbackInputStream_UnreadAheadLimit_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut PushbackInputStream_UnreadAheadLimit_safeunread_6(PushbackInputStream p, int len) : (call(* PushbackInputStream+.unread(byte[], int, int)) && target(p) && args(.., len)) && MOP_CommonPointCut();
	before (PushbackInputStream p, int len) : PushbackInputStream_UnreadAheadLimit_safeunread_6(p, len) {
		//PushbackInputStream_UnreadAheadLimit_unsafeunread_6
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.unsafeunreadEvent(p, len);
		//PushbackInputStream_UnreadAheadLimit_safeunread_6
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.safeunreadEvent(p, len);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_safeunread_5(PushbackInputStream p, Object b) : (call(* PushbackInputStream+.unread(byte[])) && target(p) && args(b)) && MOP_CommonPointCut();
	before (PushbackInputStream p, Object b) : PushbackInputStream_UnreadAheadLimit_safeunread_5(p, b) {
		//PushbackInputStream_UnreadAheadLimit_unsafeunread_5
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.unsafeunreadEvent(p, b);
		//PushbackInputStream_UnreadAheadLimit_safeunread_5
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.safeunreadEvent(p, b);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_safeunread_4(PushbackInputStream p) : (call(* PushbackInputStream+.unread(int)) && target(p)) && MOP_CommonPointCut();
	before (PushbackInputStream p) : PushbackInputStream_UnreadAheadLimit_safeunread_4(p) {
		//PushbackInputStream_UnreadAheadLimit_unsafeunread_4
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.unsafeunreadEvent(p);
		//PushbackInputStream_UnreadAheadLimit_safeunread_4
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.safeunreadEvent(p);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_create_3() : (call(PushbackInputStream+.new(InputStream))) && MOP_CommonPointCut();
	after () returning (PushbackInputStream p) : PushbackInputStream_UnreadAheadLimit_create_3() {
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.createEvent(p);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_create_4(int size) : (call(PushbackInputStream+.new(InputStream, int)) && args(.., size)) && MOP_CommonPointCut();
	after (int size) returning (PushbackInputStream p) : PushbackInputStream_UnreadAheadLimit_create_4(size) {
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.createEvent(size, p);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_read_3(PushbackInputStream p) : (call(* PushbackInputStream+.read()) && target(p)) && MOP_CommonPointCut();
	after (PushbackInputStream p) returning (int r) : PushbackInputStream_UnreadAheadLimit_read_3(p) {
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.readEvent(p, r);
	}

	pointcut PushbackInputStream_UnreadAheadLimit_read_4(PushbackInputStream p) : (call(* PushbackInputStream+.read(byte[], int, int)) && target(p)) && MOP_CommonPointCut();
	after (PushbackInputStream p) returning (int n) : PushbackInputStream_UnreadAheadLimit_read_4(p) {
		PushbackInputStream_UnreadAheadLimitRuntimeMonitor.readEvent(p, n);
	}

}
