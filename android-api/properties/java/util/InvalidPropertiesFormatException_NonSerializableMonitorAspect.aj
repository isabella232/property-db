package mop;
import java.util.*;
import java.io.*;
import rvmonitorrt.MOPLogging;
import rvmonitorrt.MOPLogging.Level;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import rvmonitorrt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

public aspect InvalidPropertiesFormatException_NonSerializableMonitorAspect implements rvmonitorrt.RVMObject {
	public InvalidPropertiesFormatException_NonSerializableMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock InvalidPropertiesFormatException_NonSerializable_MOPLock = new ReentrantLock();
	static Condition InvalidPropertiesFormatException_NonSerializable_MOPLock_cond = InvalidPropertiesFormatException_NonSerializable_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(rvmonitorrt.RVMObject+) && !adviceexecution();
	pointcut InvalidPropertiesFormatException_NonSerializable_serialize(ObjectOutputStream out, InvalidPropertiesFormatException obj) : (call(* ObjectOutputStream+.writeObject(..)) && target(out) && args(obj)) && MOP_CommonPointCut();
	before (ObjectOutputStream out, InvalidPropertiesFormatException obj) : InvalidPropertiesFormatException_NonSerializable_serialize(out, obj) {
		InvalidPropertiesFormatException_NonSerializableRuntimeMonitor.serializeEvent(out, obj);
	}

	pointcut InvalidPropertiesFormatException_NonSerializable_deserialize(ObjectInputStream in) : (call(* ObjectInputStream+.readObject(..)) && target(in)) && MOP_CommonPointCut();
	after (ObjectInputStream in) returning (InvalidPropertiesFormatException obj) : InvalidPropertiesFormatException_NonSerializable_deserialize(in) {
		InvalidPropertiesFormatException_NonSerializableRuntimeMonitor.deserializeEvent(in, obj);
	}

}
