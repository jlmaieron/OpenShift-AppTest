package com.jlmaieron.rest.ping;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * url: http://localhost:8010/testrest/resources/ping
 */
@Path("ping")
public class PingResource {

    @GET
    public String ping() {
        return "Hello World!!!!!";
    }

}
