package Database;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.*;
import javax.naming.*;
import javax.sql.*;



public class Database {
     private InitialContext inCtx;
     private DataSource ds;
     private String  dbname;
     private Connection conn;
     private ResultSet rs;
     private PreparedStatement stmt;
     private boolean isSelect = false;

    /**
     *
     * @throws NamingException
     * @throws SQLException
     */
    public Database() throws NamingException,SQLException{
        
        //ds = (DataSource)inCtx.lookup("java:/mondwh");

    }
    
    /**
     *
     * @return
     */
    public Connection getConnection(){
        return conn;
    }

    /**
     *
     * @param dbid
     * @throws NamingException
     * @throws SQLException
     */
    public void connect(int dbid) throws NamingException,SQLException {
        
        inCtx = new InitialContext();
        if ( dbid==1 ) {
            dbname="MR2-APP-UAT";
        }else if ( dbid==2 ){
            dbname="DWHPRD.BMIDWH";
        }
            
        
        ds = (DataSource)inCtx.lookup(dbname);
        inCtx.close();
        conn = ds.getConnection();
        
    }

    /**
     *
     * @param sql
     * @return
     * @throws SQLException
     */
    public ResultSet executeQuery(String sql)throws SQLException {
        isSelect = true;
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        return rs;
    }

    /**
     *
     * @param sql
     * @return 
     * @throws SQLException
     */
    public ResultSet executeUpdate(String sql)throws SQLException {
        isSelect = false;
        stmt = conn.prepareStatement(sql);
        stmt.executeUpdate();
        return rs;
    }

    /**
     *
     * @throws SQLException
     */
    public void close() throws SQLException {
        
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();  // return to pool
            if (conn != null) conn.close();  // return to pool
        
    }

}



