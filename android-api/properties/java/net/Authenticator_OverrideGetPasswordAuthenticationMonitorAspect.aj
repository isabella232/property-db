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

public aspect Authenticator_OverrideGetPasswordAuthenticationMonitorAspect implements rvmonitorrt.RVMObject {
	public Authenticator_OverrideGetPasswordAuthenticationMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Authenticator_OverrideGetPasswordAuthentication_MOPLock = new ReentrantLock();
	static Condition Authenticator_OverrideGetPasswordAuthentication_MOPLock_cond = Authenticator_OverrideGetPasswordAuthentication_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Authenticator_OverrideGetPasswordAuthentication_staticinit() : (staticinitialization(Authenticator+)) && MOP_CommonPointCut();
	after () : Authenticator_OverrideGetPasswordAuthentication_staticinit() {
		Authenticator_OverrideGetPasswordAuthenticationRuntimeMonitor.staticinitEvent();
	}

}
