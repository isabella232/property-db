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

public aspect ContentHandler_GetContentMonitorAspect implements rvmonitorrt.RVMObject {
	public ContentHandler_GetContentMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock ContentHandler_GetContent_MOPLock = new ReentrantLock();
	static Condition ContentHandler_GetContent_MOPLock_cond = ContentHandler_GetContent_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut ContentHandler_GetContent_get_content() : (call(* ContentHandler+.getContent(..))) && MOP_CommonPointCut();
	before () : ContentHandler_GetContent_get_content() {
		ContentHandler_GetContentRuntimeMonitor.get_contentEvent();
	}

}
