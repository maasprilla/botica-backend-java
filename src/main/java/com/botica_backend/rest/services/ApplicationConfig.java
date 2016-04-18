package com.botica_backend.rest.services;

import javax.ws.rs.ApplicationPath;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.filter.RolesAllowedDynamicFeature;

/**
 *
 * @author usuario
 */

@ApplicationPath("webresources")
public class ApplicationConfig extends ResourceConfig {

    public ApplicationConfig() {
        packages("com.botica_backend.rest.services;com.botica_backend.rest.auth");
        register (RolesAllowedDynamicFeature.class);
    }
}
