package mop;
import java.net.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect ServerSocket_SetTimeoutBeforeBlockingMonitorAspect implements rvmonitorrt.RVMObject {
	public ServerSocket_SetTimeoutBeforeBlockingMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock ServerSocket_SetTimeoutBeforeBlocking_MOPLock = new ReentrantLock();
	static Condition ServerSocket_SetTimeoutBeforeBlocking_MOPLock_cond = ServerSocket_SetTimeoutBeforeBlocking_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut ServerSocket_SetTimeoutBeforeBlocking_set(ServerSocket sock, int timeout) : (call(* ServerSocket+.setSoTimeout(int)) && target(sock) && args(timeout)) && MOP_CommonPointCut();
	before (ServerSocket sock, int timeout) : ServerSocket_SetTimeoutBeforeBlocking_set(sock, timeout) {
		ServerSocket_SetTimeoutBeforeBlockingRuntimeMonitor.setEvent(sock, timeout);
	}

	pointcut ServerSocket_SetTimeoutBeforeBlocking_enter(ServerSocket sock) : (call(* ServerSocket+.accept(..)) && target(sock)) && MOP_CommonPointCut();
	before (ServerSocket sock) : ServerSocket_SetTimeoutBeforeBlocking_enter(sock) {
		ServerSocket_SetTimeoutBeforeBlockingRuntimeMonitor.enterEvent(sock);
	}

	pointcut ServerSocket_SetTimeoutBeforeBlocking_leave(ServerSocket sock) : (call(* ServerSocket+.accept(..)) && target(sock)) && MOP_CommonPointCut();
	after (ServerSocket sock) : ServerSocket_SetTimeoutBeforeBlocking_leave(sock) {
		ServerSocket_SetTimeoutBeforeBlockingRuntimeMonitor.leaveEvent(sock);
	}

}
