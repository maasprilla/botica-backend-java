/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.rest.services;

import com.botica_backend.models.Contacto;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

/**
 *
 * @author Luis
 */
@Path("email")
public class EmailRest {

    @POST
    @Path("contacto")
    @Consumes(MediaType.APPLICATION_JSON)
    public void contacto(Contacto contacto) {
        try {
            HtmlEmail email = new HtmlEmail();

            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(465);
            email.setAuthenticator(new DefaultAuthenticator("miguelasprilla1994@gmail.com", "94090806909"));
            email.setSSL(true);
            email.setFrom("services@botica.com");
            email.setSubject("Restablecer Contraseña Botica");
            email.setHtmlMsg("<h1>Restablecer Contraseña</h1> Nombre: " + contacto.getNombre() + "Email: " + contacto.getEmail() + "Mensaje: " + contacto.getMensaje() + " que dice fufin :3");
            // email.add("djaranzazu@misena.edu.co","maasprilla35@misena.edu.co","hjhenao@misena.edu.co","iyaguirre@misena.edu.co","jcpolanco23@misena.edu.co","aelopez346@misena.edu.co"); //este email es el destinatario, osea el tuyo mismo si queres que te llegen a tu bandeja de entrada
            email.addTo("maasprilla35@misena.edu.co");
            email.addTo("djaranzazu@misena.edu.co"); //este email es el destinatario, osea el tuyo mismo si queres que te llegen a tu bandeja de entrada
            email.addTo("hjhenao@misena.edu.co");
            email.addTo("iyaguirre@misena.edu.co");
            email.addTo("jcpolanco23@misena.edu.co");
            email.addTo("aelopez346@misena.edu.co");
            email.send();
        } catch (EmailException ex) {
            Logger.getLogger(EmailRest.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
