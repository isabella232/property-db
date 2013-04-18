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

public aspect URLConnection_SetBeforeConnectMonitorAspect implements rvmonitorrt.RVMObject {
	public URLConnection_SetBeforeConnectMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock URLConnection_SetBeforeConnect_MOPLock = new ReentrantLock();
	static Condition URLConnection_SetBeforeConnect_MOPLock_cond = URLConnection_SetBeforeConnect_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut URLConnection_SetBeforeConnect_connect(URLConnection c) : ((call(* URLConnection+.connect(..)) || call(* URLConnection+.getContent(..)) || call(* URLConnection+.getContentEncoding(..)) || call(* URLConnection+.getContentLength(..)) || call(* URLConnection+.getContentType(..)) || call(* URLConnection+.getDate(..)) || call(* URLConnection+.getExpiration(..)) || call(* URLConnection+.getHeaderField(..)) || call(* URLConnection+.getHeaderFieldInt(..)) || call(* URLConnection+.getHeaderFields(..)) || call(* URLConnection+.getInputStream(..)) || call(* URLConnection+.getLastModified(..)) || call(* URLConnection+.getOutputStream(..))) && target(c)) && MOP_CommonPointCut();
	before (URLConnection c) : URLConnection_SetBeforeConnect_connect(c) {
		URLConnection_SetBeforeConnectRuntimeMonitor.connectEvent(c);
	}

	pointcut URLConnection_SetBeforeConnect_set(URLConnection c) : (call(* URLConnection+.set*(..)) && target(c)) && MOP_CommonPointCut();
	before (URLConnection c) : URLConnection_SetBeforeConnect_set(c) {
		URLConnection_SetBeforeConnectRuntimeMonitor.setEvent(c);
	}

}
