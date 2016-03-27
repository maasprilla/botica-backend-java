
package com.botica_backend.rest.auth;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author usuario
 */
public class Token {
    String token;
    
    public Token (@JsonProperty("token") String token) {
        this.token = token;
    }
    
    public String getToken() {
        return token;
    }
}
