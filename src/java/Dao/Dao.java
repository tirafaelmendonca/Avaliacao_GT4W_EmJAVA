package Dao;

import java.sql.*;
import javax.swing.JOptionPane;

public class Dao {

    public Dao() {
    }

    public static Connection getConnection()
            throws Exception {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://gt4w_avaliacao.mysql.dbaas.com.br:3306/gt4w_avaliacao?characterEncoding=utf8&autoReconnct=true", "gt4w_avaliacao", "gt4w@avaliacao");
        } catch (Exception e) {
            throw new Exception((new StringBuilder()).append("Erro ao conectar a base de dados: ").append(e.getMessage()).toString());
        }
    }

    public static void close(Connection con, Statement stm, ResultSet rs)
            throws Exception {
        try {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            throw new Exception((new StringBuilder()).append("Erro ao desconectar da base de dados: ").append(e.getMessage()).toString());
        }
    }

    public static void closeConnection(Connection con) {
        try {
            close(con, null, null);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }

    public static void closeConnection(Connection con, Statement stm) {
        try {
            close(con, stm, null);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }

    public static void closeConnection(Connection con, Statement stm, ResultSet rs) {
        try {
            close(con, stm, rs);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
}
