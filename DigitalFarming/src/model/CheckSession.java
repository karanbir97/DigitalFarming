package model;

import java.io.Serializable;

import javax.servlet.http.*;

public class CheckSession implements Serializable{

	private static final long serialVersionUID = 1L;

	public CheckSession(Integer t, HttpSession s) {
		this.setSession(s);	
		this.setTipoCheck(t);
		this.setUrlRedirect("/accedi.jsp");
	}
	
	public Integer getTipoCheck() {
		return this.tipoCheck;
	}

	public void setTipoCheck(Integer tipoCheck) {
		this.tipoCheck = tipoCheck;
	}

	public HttpSession getSession() {
		return this.session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public boolean getRedirect() {				
		/*
		if(this.getSession().getAttribute("carrello") == null) { //Se non trova il carrello per qualsiasi motivo, ricreo il carrello
			this.getSession().setAttribute("carrello", new Carrello((Integer) this.getSession().getAttribute("id_utente")));
		}		
		*/
		if(this.getTipoCheck() == 1) { //Amministrazione
			//System.out.println("ID UTENTE:"+this.getSession().getAttribute("id_utente"));
			//System.out.println("TIPO UTENTE:"+this.getSession().getAttribute("tipo_utente"));
			//System.out.println(this.getTipoUtente(1));			
			if((Integer) this.getSession().getAttribute("id_utente") == null || (Integer) this.getSession().getAttribute("id_utente") <= 0 || (Integer) this.getSession().getAttribute("tipo_utente") == null || (Integer) this.getSession().getAttribute("tipo_utente") != 1) {
				this.setRedirect(true);
			}
		}
		else if(this.getTipoCheck() == 0) { //Frontend
			//System.out.println("ID UTENTE:"+this.getSession().getAttribute("id_utente"));
			//System.out.println("TIPO UTENTE:"+this.getSession().getAttribute("tipo_utente"));
			//System.out.println(this.getTipoUtente(0));			
			if((Integer) this.getSession().getAttribute("id_utente") == null || (Integer) this.getSession().getAttribute("id_utente") <= 0 || (Integer) this.getSession().getAttribute("tipo_utente") == null || (Integer) this.getSession().getAttribute("tipo_utente") != 2) {
				this.setRedirect(true);
			}
		}
		return this.redirect;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}


	public String getUrlRedirect() {
		return this.urlRedirect;
	}

	public void setUrlRedirect(String urlRedirect) {
		this.urlRedirect = urlRedirect;
	}

	private Integer tipoCheck;
	private boolean redirect;
	private String urlRedirect;
	private HttpSession session;
}
