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

public aspect URLConnection_ConnectMonitorAspect implements rvmonitorrt.RVMObject {
	public URLConnection_ConnectMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock URLConnection_Connect_MOPLock = new ReentrantLock();
	static Condition URLConnection_Connect_MOPLock_cond = URLConnection_Connect_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut URLConnection_Connect_implicit(URLConnection c) : ((call(* URLConnection+.getContent(..)) || call(* URLConnection+.getContentEncoding(..)) || call(* URLConnection+.getContentLength(..)) || call(* URLConnection+.getContentType(..)) || call(* URLConnection+.getDate(..)) || call(* URLConnection+.getExpiration(..)) || call(* URLConnection+.getHeaderField(..)) || call(* URLConnection+.getHeaderFieldInt(..)) || call(* URLConnection+.getHeaderFields(..)) || call(* URLConnection+.getInputStream(..)) || call(* URLConnection+.getLastModified(..)) || call(* URLConnection+.getOutputStream(..))) && target(c)) && MOP_CommonPointCut();
	before (URLConnection c) : URLConnection_Connect_implicit(c) {
		URLConnection_ConnectRuntimeMonitor.implicitEvent(c);
	}

	pointcut URLConnection_Connect_explicit(URLConnection c) : (call(* URLConnection+.connect(..)) && target(c)) && MOP_CommonPointCut();
	before (URLConnection c) : URLConnection_Connect_explicit(c) {
		URLConnection_ConnectRuntimeMonitor.explicitEvent(c);
	}

}
