package mop;
import java.lang.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect ShutdownHook_LateRegisterMonitorAspect implements rvmonitorrt.RVMObject {
	public ShutdownHook_LateRegisterMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock ShutdownHook_LateRegister_MOPLock = new ReentrantLock();
	static Condition ShutdownHook_LateRegister_MOPLock_cond = ShutdownHook_LateRegister_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut ShutdownHook_LateRegister_register(Thread t) : (call(* Runtime+.addShutdownHook(..)) && args(t)) && MOP_CommonPointCut();
	after (Thread t) : ShutdownHook_LateRegister_register(t) {
		ShutdownHook_LateRegisterRuntimeMonitor.registerEvent(t);
	}

	pointcut ShutdownHook_LateRegister_unregister(Thread t) : (call(* Runtime+.removeShutdownHook(..)) && args(t)) && MOP_CommonPointCut();
	after (Thread t) : ShutdownHook_LateRegister_unregister(t) {
		ShutdownHook_LateRegisterRuntimeMonitor.unregisterEvent(t);
	}

	static HashMap<Thread, Runnable> ShutdownHook_LateRegister_start_ThreadToRunnable = new HashMap<Thread, Runnable>();
	static Thread ShutdownHook_LateRegister_start_MainThread = null;

	after (Runnable r) returning (Thread t): ((call(Thread+.new(Runnable+,..)) && args(r,..))|| (initialization(Thread+.new(ThreadGroup+, Runnable+,..)) && args(ThreadGroup, r,..))) && MOP_CommonPointCut() {
		while (!ShutdownHook_LateRegister_MOPLock.tryLock()) {
			Thread.yield();
		}
		ShutdownHook_LateRegister_start_ThreadToRunnable.put(t, r);
		ShutdownHook_LateRegister_MOPLock.unlock();
	}

	before (Thread t_1): ( execution(void Thread+.run()) && target(t_1) ) && MOP_CommonPointCut() {
		if(Thread.currentThread() == t_1) {
			Thread t = Thread.currentThread();
			ShutdownHook_LateRegisterRuntimeMonitor.startEvent(t);
		}
	}

	before (Runnable r): ( execution(void Runnable+.run()) && !execution(void Thread+.run()) && target(r) ) && MOP_CommonPointCut() {
		while (!ShutdownHook_LateRegister_MOPLock.tryLock()) {
			Thread.yield();
		}
		if(ShutdownHook_LateRegister_start_ThreadToRunnable.get(Thread.currentThread()) == r) {
			Thread t = Thread.currentThread();
			ShutdownHook_LateRegisterRuntimeMonitor.startEvent(t);
		}
		ShutdownHook_LateRegister_MOPLock.unlock();
	}

	before (): (execution(void *.main(..)) ) && MOP_CommonPointCut() {
		if(ShutdownHook_LateRegister_start_MainThread == null){
			ShutdownHook_LateRegister_start_MainThread = Thread.currentThread();
			Thread t = Thread.currentThread();
			ShutdownHook_LateRegisterRuntimeMonitor.startEvent(t);
		}
	}

}
