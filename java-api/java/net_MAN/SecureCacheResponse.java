/*
 * Copyright (c) 2003, 2004, Oracle and/or its affiliates. All rights reserved.
 * ORACLE PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */

package java.net;

import java.security.cert.Certificate;
import javax.net.ssl.SSLPeerUnverifiedException;
import java.security.Principal;
import java.util.List;

/** {@collect.stats} 
 * {@description.open}
 * Represents a cache response originally retrieved through secure
 * means, such as TLS.
 * {@description.close}
 *
 * @since 1.5
 */
public abstract class SecureCacheResponse extends CacheResponse {
    /** {@collect.stats} 
     * {@description.open}
     * Returns the cipher suite in use on the original connection that
     * retrieved the network resource.
     * {@description.close}
     *
     * @return a string representing the cipher suite
     */
    public abstract String getCipherSuite();

    /** {@collect.stats} 
     * {@description.open}
     * Returns the certificate chain that were sent to the server during
     * handshaking of the original connection that retrieved the
     * network resource.
     * {@description.close}
     * {@property.open unchecked}
     * Note: This method is useful only
     * when using certificate-based cipher suites.
     * {@property.close}
     *
     * @return an immutable List of Certificate representing the
     *           certificate chain that was sent to the server. If no
     *           certificate chain was sent, null will be returned.
     * @see #getLocalPrincipal()
     */
    public abstract List<Certificate> getLocalCertificateChain();

    /** {@collect.stats} 
     * {@description.open}
     * Returns the server's certificate chain, which was established as
     * part of defining the session in the original connection that
     * retrieved the network resource, from cache.
     * {@description.close}
     * {@property.open unchecked}
     * Note: This method
     * can be used only when using certificate-based cipher suites;
     * using it with non-certificate-based cipher suites, such as
     * Kerberos, will throw an SSLPeerUnverifiedException.
     * {@property.close}
     *
     * @return an immutable List of Certificate representing the server's
     *         certificate chain.
     * @throws SSLPeerUnverifiedException if the peer is not verified.
     * @see #getPeerPrincipal()
     */
    public abstract List<Certificate> getServerCertificateChain()
        throws SSLPeerUnverifiedException;

    /** {@collect.stats} 
     * {@description.open}
     * Returns the server's principal which was established as part of
     * defining the session during the original connection that
     * retrieved the network resource.
     * {@description.close}
     *
     * @return the server's principal. Returns an X500Principal of the
     * end-entity certiticate for X509-based cipher suites, and
     * KerberosPrincipal for Kerberos cipher suites.
     *
     * @throws SSLPeerUnverifiedException if the peer was not verified.
     *
     * @see #getServerCertificateChain()
     * @see #getLocalPrincipal()
     */
     public abstract Principal getPeerPrincipal()
             throws SSLPeerUnverifiedException;

    /** {@collect.stats} 
     * {@description.open}
      * Returns the principal that was sent to the server during
      * handshaking in the original connection that retrieved the
      * network resource.
      * {@description.close}
      *
      * @return the principal sent to the server. Returns an X500Principal
      * of the end-entity certificate for X509-based cipher suites, and
      * KerberosPrincipal for Kerberos cipher suites. If no principal was
      * sent, then null is returned.
      *
      * @see #getLocalCertificateChain()
      * @see #getPeerPrincipal()
      */
     public abstract Principal getLocalPrincipal();
}