/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.rest.services;

import com.botica_backend.entities.Usuario;
import com.botica_backend.models.RecoveryPassword;
import com.botica_backend.rest.auth.DigestUtil;
import com.botica_backend.sessions.UsuarioSession;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

/**
 *
 * @author Luis
 */
@Path("email")
@Stateless
public class EmailRest {

    @EJB
    UsuarioSession usuarioSession;

    @POST
    @Path("recoverypass")
    @Consumes(MediaType.APPLICATION_JSON)
    public void recoveryPass(RecoveryPassword recoveryPassword) {
        try {

            Usuario user = usuarioSession.findByEmail(recoveryPassword.getEmail());
            int x = (int) (Math.random() * 1000);

            String cd = null;
            try {
                cd = DigestUtil.generateDigest(String.valueOf(x));
            } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
                Logger.getLogger(Usuario.class.getName()).log(Level.SEVERE, null, ex);
            }

            HtmlEmail email = new HtmlEmail();

            email.setHostName("smtp.gmail.com");
            email.setSmtpPort(465);
            email.setAuthenticator(new DefaultAuthenticator("miguelasprilla1994@gmail.com", "94090806909"));
            email.setSSL(true);
            email.setFrom("services@botica.com");
            email.setSubject("Restablecer Contraseña Botica");
            email.setHtmlMsg("<h1 style=" + "color:blue;" + ">Restablecer Contraseña</h1> Email: " + recoveryPassword.getEmail() + " abra e siguiente enlace para continuar con el proceso de recuperacion es http://localhost:8001/#/passconfrm/" + user.getIdUsuario() + "/" + cd);
            // email.add("djaranzazu@misena.edu.co","maasprilla35@misena.edu.co","hjhenao@misena.edu.co","iyaguirre@misena.edu.co","jcpolanco23@misena.edu.co","aelopez346@misena.edu.co"); //este email es el destinatario, osea el tuyo mismo si queres que te llegen a tu bandeja de entrada
//            email.addTo("maasprilla35@misena.edu.co");
//            email.addTo("djaranzazu@misena.edu.co"); //este email es el destinatario, osea el tuyo mismo si queres que te llegen a tu bandeja de entrada
//            email.addTo("hjhenao@misena.edu.co");
//            email.addTo("iyaguirre@misena.edu.co");
//            email.addTo("jcpolanco23@misena.edu.co");
//            email.addTo("aelopez346@misena.edu.co");
            email.addTo(recoveryPassword.getEmail());
            email.send();
        } catch (EmailException ex) {
            Logger.getLogger(EmailRest.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
