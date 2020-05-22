package model;

public class Prodotto {
	public Prodotto(Integer id_prodotto, Integer quantita) {
		this.setIdProdotto(id_prodotto);
		this.setQuantita(quantita);
	}
	public Integer getQuantita() {		
		return this.quantita;
	}
	public void setQuantita(Integer quantita) {
		this.quantita = quantita;
	}
	public Integer getIdProdotto() {
		return this.id_prodotto;
	}
	public void setIdProdotto(Integer id_prodotto) {
		this.id_prodotto = id_prodotto;
	}
	
	public String toString() {
		return this.getClass().getName()+"["+this.getIdProdotto()+"]["+this.getQuantita()+"]";
	}

	private Integer id_prodotto;
	private Integer quantita;
}
