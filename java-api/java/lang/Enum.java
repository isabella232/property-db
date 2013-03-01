/*
 * Copyright (c) 2003, 2007, Oracle and/or its affiliates. All rights reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This code is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 only, as
 * published by the Free Software Foundation.  Oracle designates this
 * particular file as subject to the "Classpath" exception as provided
 * by Oracle in the LICENSE file that accompanied this code.
 *
 * This code is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * version 2 for more details (a copy is included in the LICENSE file that
 * accompanied this code).
 *
 * You should have received a copy of the GNU General Public License version
 * 2 along with this work; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
 * or visit www.oracle.com if you need additional information or have any
 * questions.
 */

package java.lang;

import java.io.Serializable;
import java.io.IOException;
import java.io.InvalidObjectException;
import java.io.ObjectInputStream;
import java.io.ObjectStreamException;

/** {@collect.stats}
 * {@description.open}
 * This is the common base class of all Java language enumeration types.
 * {@description.close}
 *
 * @author  Josh Bloch
 * @author  Neal Gafter
 * @see     Class#getEnumConstants()
 * @since   1.5
 */
public abstract class Enum<E extends Enum<E>>
        implements Comparable<E>, Serializable {
    /** {@collect.stats}
     * {@description.open}
     * The name of this enum constant, as declared in the enum declaration.
     * Most programmers should use the {@link #toString} method rather than
     * accessing this field.
     * {@description.close}
     */
    private final String name;

    /** {@collect.stats}
     * {@description.open}
     * Returns the name of this enum constant, exactly as declared in its
     * enum declaration.
     * {@description.close}
     *
     * {@property.open runtime formal:java.lang.Enum_UserFriendlyName}
     * <b>Most programmers should use the {@link #toString} method in
     * preference to this one, as the toString method may return
     * a more user-friendly name.</b>
     * {@property.close}
     * {@description.open}
     * This method is designed primarily for
     * use in specialized situations where correctness depends on getting the
     * exact name, which will not vary from release to release.
     * {@description.close}
     *
     * @return the name of this enum constant
     */
    public final String name() {
        return name;
    }

    /** {@collect.stats}
     * {@description.open}
     * The ordinal of this enumeration constant (its position
     * in the enum declaration, where the initial constant is assigned
     * an ordinal of zero).
     *
     * Most programmers will have no use for this field.  It is designed
     * for use by sophisticated enum-based data structures, such as
     * {@link java.util.EnumSet} and {@link java.util.EnumMap}.
     * {@description.close}
     */
    private final int ordinal;

    /** {@collect.stats}
     * {@description.open}
     * Returns the ordinal of this enumeration constant (its position
     * in its enum declaration, where the initial constant is assigned
     * an ordinal of zero).
     * {@description.close}
     * {@property.open runtime formal:java.lang.Enum_NoOrdinal}
     * Most programmers will have no use for this method.  It is
     * designed for use by sophisticated enum-based data structures, such
     * as {@link java.util.EnumSet} and {@link java.util.EnumMap}.
     * {@property.close}
     *
     * @return the ordinal of this enumeration constant
     */
    public final int ordinal() {
        return ordinal;
    }

    /** {@collect.stats}
     * {@description.open}
     * Sole constructor.
     * {@description.close}
     * {@property.open static}
     * Programmers cannot invoke this constructor.
     * It is for use by code emitted by the compiler in response to
     * enum type declarations.
     * {@property.close}
     *
     * @param name - The name of this enum constant, which is the identifier
     *               used to declare it.
     * @param ordinal - The ordinal of this enumeration constant (its position
     *         in the enum declaration, where the initial constant is assigned
     *         an ordinal of zero).
     */
    protected Enum(String name, int ordinal) {
        this.name = name;
        this.ordinal = ordinal;
    }

    /** {@collect.stats}
     * {@description.open}
     * Returns the name of this enum constant, as contained in the
     * declaration.
     * {@description.close}
     * {@property.open static}  
     * This method may be overridden, though it typically
     * isn't necessary or desirable.
     * {@property.close}
     * {@property.open static}
     * An enum type should override this
     * method when a more "programmer-friendly" string form exists.
     * {@property.close}
     *
     * @return the name of this enum constant
     */
    public String toString() {
        return name;
    }

    /** {@collect.stats}
     * {@description.open}
     * Returns true if the specified object is equal to this
     * enum constant.
     * {@description.close}
     *
     * @param other the object to be compared for equality with this object.
     * @return  true if the specified object is equal to this
     *          enum constant.
     */
    public final boolean equals(Object other) {
        return this==other;
    }

    /** {@collect.stats}
     * {@description.open}
     * Returns a hash code for this enum constant.
     * {@description.close}
     *
     * @return a hash code for this enum constant.
     */
    public final int hashCode() {
        return super.hashCode();
    }

    /** {@collect.stats}
     * {@description.open}
     * Throws CloneNotSupportedException.  This guarantees that enums
     * are never cloned, which is necessary to preserve their "singleton"
     * status.
     * {@description.close}
     *
     * @return (never returns)
     */
    protected final Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    /** {@collect.stats}
     * {@description.open}
     * Compares this enum with the specified object for order.  Returns a
     * negative integer, zero, or a positive integer as this object is less
     * than, equal to, or greater than the specified object.
     *
     * Enum constants are only comparable to other enum constants of the
     * same enum type.  The natural order implemented by this
     * method is the order in which the constants are declared.
     * {@description.close}
     */
    public final int compareTo(E o) {
        Enum other = (Enum)o;
        Enum self = this;
        if (self.getClass() != other.getClass() && // optimization
            self.getDeclaringClass() != other.getDeclaringClass())
            throw new ClassCastException();
        return self.ordinal - other.ordinal;
    }

    /** {@collect.stats}
     * {@description.open}
     * Returns the Class object corresponding to this enum constant's
     * enum type.  Two enum constants e1 and  e2 are of the
     * same enum type if and only if
     *   e1.getDeclaringClass() == e2.getDeclaringClass().
     * (The value returned by this method may differ from the one returned
     * by the {@link Object#getClass} method for enum constants with
     * constant-specific class bodies.)
     * {@description.close}
     *
     * @return the Class object corresponding to this enum constant's
     *     enum type
     */
    public final Class<E> getDeclaringClass() {
        Class clazz = getClass();
        Class zuper = clazz.getSuperclass();
        return (zuper == Enum.class) ? clazz : zuper;
    }

    /** {@collect.stats}
     * {@description.open}
     * Returns the enum constant of the specified enum type with the
     * specified name.  The name must match exactly an identifier used
     * to declare an enum constant in this type.
     * {@description.close}
     * {@property.open runtime formal:java.lang.Enum_NoExtraWhiteSpace}
     * (Extraneous whitespace
     * characters are not permitted.)
     * {@property.close}
     *
     * @param enumType the {@code Class} object of the enum type from which
     *      to return a constant
     * @param name the name of the constant to return
     * @return the enum constant of the specified enum type with the
     *      specified name
     * @throws IllegalArgumentException if the specified enum type has
     *         no constant with the specified name, or the specified
     *         class object does not represent an enum type
     * @throws NullPointerException if {@code enumType} or {@code name}
     *         is null
     * @since 1.5
     */
    public static <T extends Enum<T>> T valueOf(Class<T> enumType,
                                                String name) {
        T result = enumType.enumConstantDirectory().get(name);
        if (result != null)
            return result;
        if (name == null)
            throw new NullPointerException("Name is null");
        throw new IllegalArgumentException(
            "No enum const " + enumType +"." + name);
    }

    /** {@collect.stats}
     * {@description.open}
     * enum classes cannot have finalize methods.
     * {@description.close}
     */
    protected final void finalize() { }

    /** {@collect.stats}
     * {@description.open}
     * prevent default deserialization
     * {@description.close}
     */
    private void readObject(ObjectInputStream in) throws IOException,
        ClassNotFoundException {
            throw new InvalidObjectException("can't deserialize enum");
    }

    private void readObjectNoData() throws ObjectStreamException {
            throw new InvalidObjectException("can't deserialize enum");
    }
}