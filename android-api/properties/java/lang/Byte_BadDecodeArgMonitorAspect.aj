package mop;
import java.io.*;
import java.lang.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect Byte_BadDecodeArgMonitorAspect implements rvmonitorrt.RVMObject {
	public Byte_BadDecodeArgMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Byte_BadDecodeArg_MOPLock = new ReentrantLock();
	static Condition Byte_BadDecodeArg_MOPLock_cond = Byte_BadDecodeArg_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut Byte_BadDecodeArg_decode(Byte b, String nm) : (call(* Byte.decode(String)) && target(b) && args(nm)) && MOP_CommonPointCut();
	before (Byte b, String nm) : Byte_BadDecodeArg_decode(b, nm) {
		Byte_BadDecodeArgRuntimeMonitor.decodeEvent(b, nm);
	}

}
