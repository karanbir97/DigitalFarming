package model;

import java.math.BigDecimal;

public class SystemInformation {
	
	public SystemInformation() {
		this.setPathImmaginiProdotto("T:\\Dati\\Dropbox\\Dropbox\\UNI\\Secondo Anno\\Tecnologie Software per il Web\\Java EE\\Workspace\\BUCCELLA_MACELLARO_MAIORANO\\WebContent\\images\\prodotti\\");		
		this.setPathImmaginiProdottoHTML("/BUCCELLA_MACELLARO_MAIORANO/images/prodotti/");		
		this.setPathImmaginiProdottoDefault("/BUCCELLA_MACELLARO_MAIORANO/images/prodotti/prodotto_blank.png");
		this.setUrlRedirect("/accedi.jsp");				
		this.setLimiteProdottiIndex(9);
	}

	public String getPathImmaginiProdottoHTML() {		
		return pathImmaginiProdottoHTML; 
	}	
	public void setPathImmaginiProdottoHTML(String pathImmaginiProdotto) {
		this.pathImmaginiProdottoHTML = pathImmaginiProdotto;
	}
	
	public String getPathImmaginiProdotto() {		
		return pathImmaginiProdotto; 
	}
	public void setPathImmaginiProdotto(String pathImmaginiProdotto) {
		this.pathImmaginiProdotto = pathImmaginiProdotto;
	}
	
	public String getPathImmaginiProdottoDefault() {
		return pathImmaginiProdottoDefault;
	}
	public void setPathImmaginiProdottoDefault(String pathImmaginiProdottoDefault) {
		this.pathImmaginiProdottoDefault = pathImmaginiProdottoDefault;
	}
	
	public String getUrlRedirect() {
		return urlRedirect;
	}
	public void setUrlRedirect(String urlRedirect) {
		this.urlRedirect = urlRedirect;
	}

	public Integer getLimiteProdottiIndex() {
		return limiteProdottiIndex;
	}
	public void setLimiteProdottiIndex(Integer limite) {
		this.limiteProdottiIndex = limite;
	}
	
	@SuppressWarnings("deprecation")
	public BigDecimal truncateDecimal(double x,int numberofDecimals){
	    if ( x > 0) {
	        return new BigDecimal(String.valueOf(x)).setScale(numberofDecimals, BigDecimal.ROUND_FLOOR);
	    } else {
	        return new BigDecimal(String.valueOf(x)).setScale(numberofDecimals, BigDecimal.ROUND_CEILING);
	    }
	}
	

	private String pathImmaginiProdotto;
	private String pathImmaginiProdottoHTML;
	private String pathImmaginiProdottoDefault;
	private String urlRedirect;
	private Integer limiteProdottiIndex;
}
