package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnessioneDB {
	
	public ConnessioneDB(){
		this.conn = null;
		this.server = "localhost";
		this.porta  = 3310;
		this.nomeDB = "buccella_macellaro_maiorano";
		this.userDB = "root";
		this.passDB = "root";	
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://"+this.server+":"+this.porta+"/"+this.nomeDB+"?useSSL=false";
			this.conn = DriverManager.getConnection(url, this.userDB, this.passDB);
			this.conn.setAutoCommit(false);
		}
		catch(Exception exc) {
			this.error = "Connessione Fallita \n"+exc.getMessage();
		}  
	}
	
	public Connection getConn(){
		return this.conn;
	}
	public String getError(){
		return this.error;
	}
	
	public void closeConn() throws SQLException{
		this.conn.close();
	}
	
	private Connection conn;
	private String server;
	private int porta;
	private String nomeDB;
	private String userDB;
	private String passDB;
	private String error;
}
