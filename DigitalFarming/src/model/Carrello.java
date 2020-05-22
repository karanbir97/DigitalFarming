package model;

import java.util.ArrayList;

public class Carrello {
	public Carrello(Integer id_utente) {
		this.prodotti = new ArrayList<Prodotto>();	
		this.setIdUtente(id_utente);
	}
	
	
	public ArrayList<Prodotto> getProdotti(){
		return this.prodotti;
	}
	
	public int getNumeroProdotti() {
		int i = 0;
		for(Prodotto prodotto: this.prodotti) {
		    i += prodotto.getQuantita();
		}
		return i;
	}
	
	public Prodotto getProdotto(Integer i) {		
		if(this.prodotti.get(i) != null) return this.prodotti.get(i);
		else return null;
	}

	public Prodotto getProdottoByIdProdotto(Integer id_prodotto) {
		for(Prodotto prodotto: this.prodotti) {
		    if(prodotto.getIdProdotto() == id_prodotto) {
		    	return prodotto;
		    }
		}
		return null;
	}

	public void setProdotto(Integer id_prodotto, Integer quantita) {
		Prodotto p = new Prodotto(id_prodotto, quantita);
		this.prodotti.add(p);
	}
	
	public void delProdotto(Integer id_prodotto) {
		int i = 0;
		for(Prodotto prodotto: this.getProdotti()) {
		    if(prodotto.getIdProdotto() == id_prodotto) {
		    	this.getProdotti().remove(i);
		    	return;
		    }
		    i++;
		}
	}
	
	public void modQuantProdotto(Integer id_prodotto, Integer quantita) {
		for(Prodotto prodotto: this.prodotti) {
		    if(prodotto.getIdProdotto() == id_prodotto) {
		    	prodotto.setQuantita(quantita);
		    }
		}
	}

	public Integer getIdUtente() {
		return id_utente;
	}

	public void setIdUtente(Integer id_utente) {
		this.id_utente = id_utente;
	}
	
	public String toString() {
		String prodotti = "";
		for(Prodotto prodotto: this.prodotti) {
			prodotti += "["+prodotto.toString()+"]";
		}
		return this.getClass().getName()+"["+this.getIdUtente()+"]["+prodotti+"]";
	}

	private ArrayList<Prodotto> prodotti;
	private Integer id_utente;
}
