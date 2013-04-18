package mop;
import java.net.*;
import java.lang.reflect.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect URLConnection_OverrideGetPermissionMonitorAspect implements rvmonitorrt.RVMObject {
	public URLConnection_OverrideGetPermissionMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock URLConnection_OverrideGetPermission_MOPLock = new ReentrantLock();
	static Condition URLConnection_OverrideGetPermission_MOPLock_cond = URLConnection_OverrideGetPermission_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut URLConnection_OverrideGetPermission_staticinit() : (staticinitialization(URLConnection+)) && MOP_CommonPointCut();
	after () : URLConnection_OverrideGetPermission_staticinit() {
		URLConnection_OverrideGetPermissionRuntimeMonitor.staticinitEvent();
	}

}
