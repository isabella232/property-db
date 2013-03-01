/*
 * Copyright (c) 2003, Oracle and/or its affiliates. All rights reserved.
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

package javax.sql.rowset.spi;

import java.sql.SQLException;
import java.io.Writer;

import javax.sql.RowSetWriter;
import javax.sql.rowset.*;

/** {@collect.stats}
 * A specialized interface that facilitates an extension of the
 * <code>SyncProvider</code> abstract class for XML orientated
 * synchronization providers.
 * <p>
 * <code>SyncProvider</code>  implementations that supply XML data writer
 * capabilities such as output XML stream capabilities can implement this
 * interface to provider standard <code>XmlWriter</code> objects to
 * <code>WebRowSet</code> implementations.
 * <P>
 * Writing a <code>WebRowSet</code> object includes printing the
 * rowset's data, metadata, and properties, all with the
 * appropriate XML tags.
 */
public interface XmlWriter extends RowSetWriter {

  /** {@collect.stats}
   * Writes the given <code>WebRowSet</code> object to the specified
   * <code>java.io.Writer</code> output stream as an XML document.
   * This document includes the rowset's data, metadata, and properties
   * plus the appropriate XML tags.
   * <P>
   * The <code>caller</code> parameter must be a <code>WebRowSet</code>
   * object whose <code>XmlWriter</code> field contains a reference to
   * this <code>XmlWriter</code> object.
   *
   * @param caller the <code>WebRowSet</code> instance to be written,
   *        for which this <code>XmlWriter</code> object is the writer
   * @param writer the <code>java.io.Writer</code> object that serves
   *        as the output stream for writing <code>caller</code> as
   *        an XML document
   * @throws SQLException if a database access error occurs or
   *            this <code>XmlWriter</code> object is not the writer
   *            for the given <code>WebRowSet</code> object
   */
  public void writeXML(WebRowSet caller, java.io.Writer writer)
    throws SQLException;



}