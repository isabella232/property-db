package mop;
import java.io.*;
import java.lang.*;
import java.util.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Thread_SetDaemonBeforeStartMonitorAspect implements rvmonitorrt.RVMObject {
	public Thread_SetDaemonBeforeStartMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Thread_SetDaemonBeforeStart_MOPLock = new ReentrantLock();
	static Condition Thread_SetDaemonBeforeStart_MOPLock_cond = Thread_SetDaemonBeforeStart_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Thread_SetDaemonBeforeStart_setDaemon(Thread t) : (call(* Thread+.setDaemon(..)) && target(t)) && MOP_CommonPointCut();
	before (Thread t) : Thread_SetDaemonBeforeStart_setDaemon(t) {
		Thread_SetDaemonBeforeStartRuntimeMonitor.setDaemonEvent(t);
	}

	static HashMap<Thread, Runnable> Thread_SetDaemonBeforeStart_start_ThreadToRunnable = new HashMap<Thread, Runnable>();
	static Thread Thread_SetDaemonBeforeStart_start_MainThread = null;

	after (Runnable r) returning (Thread t): ((call(Thread+.new(Runnable+,..)) && args(r,..))|| (initialization(Thread+.new(ThreadGroup+, Runnable+,..)) && args(ThreadGroup, r,..))) && MOP_CommonPointCut() {
		while (!Thread_SetDaemonBeforeStart_MOPLock.tryLock()) {
			Thread.yield();
		}
		Thread_SetDaemonBeforeStart_start_ThreadToRunnable.put(t, r);
		Thread_SetDaemonBeforeStart_MOPLock.unlock();
	}

	before (Thread t_1): ( execution(void Thread+.run()) && target(t_1) ) && MOP_CommonPointCut() {
		if(Thread.currentThread() == t_1) {
			Thread t = Thread.currentThread();
			Thread_SetDaemonBeforeStartRuntimeMonitor.startEvent(t);
		}
	}

	before (Runnable r): ( execution(void Runnable+.run()) && !execution(void Thread+.run()) && target(r) ) && MOP_CommonPointCut() {
		while (!Thread_SetDaemonBeforeStart_MOPLock.tryLock()) {
			Thread.yield();
		}
		if(Thread_SetDaemonBeforeStart_start_ThreadToRunnable.get(Thread.currentThread()) == r) {
			Thread t = Thread.currentThread();
			Thread_SetDaemonBeforeStartRuntimeMonitor.startEvent(t);
		}
		Thread_SetDaemonBeforeStart_MOPLock.unlock();
	}

	before (): (execution(void *.main(..)) ) && MOP_CommonPointCut() {
		if(Thread_SetDaemonBeforeStart_start_MainThread == null){
			Thread_SetDaemonBeforeStart_start_MainThread = Thread.currentThread();
			Thread t = Thread.currentThread();
			Thread_SetDaemonBeforeStartRuntimeMonitor.startEvent(t);
		}
	}

}
