package Controller;

import Dao.Dao;
import Model.M_pessoa;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class C_pessoa {

    Connection Con = null;
    int validacao;
    String cod_pes;
    String nome_pes;
    String cpf_pes;
    String data_pes;
    String peso_pes;
    String uf_pes;
    
   
    public M_pessoa lista_pessoa_sel(int cod_pes) throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());
            Statement stm = (Statement) this.Con.createStatement();
            ResultSet rs = stm.executeQuery("select * FROM pessoa where cod_pes="+cod_pes);
            List lista = new ArrayList();
            Model.M_pessoa m_objpes = new Model.M_pessoa();
            while (rs.next()) {
                m_objpes = new Model.M_pessoa(rs.getInt("cod_pes"), rs.getString("nome_pes"), rs.getString("cpf_pes"), rs.getString("data_pes"), rs.getString("peso_pes"), rs.getString("uf_pes"));
            }
            Dao.closeConnection(this.Con, stm, rs);
            return m_objpes;
        } catch (Exception e) {
            throw new Exception("Erro:" + e.getMessage());
        }
    }
    
    public List lista_pessoa() throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());
            Statement stm = (Statement) this.Con.createStatement();
            ResultSet rs = stm.executeQuery("select * FROM pessoa");
            List lista = new ArrayList();
            Model.M_pessoa m_objpes = new Model.M_pessoa();
            while (rs.next()) {
                
                m_objpes = new Model.M_pessoa(rs.getInt("cod_pes"), rs.getString("nome_pes"), rs.getString("cpf_pes"), rs.getString("data_pes"), rs.getString("peso_pes"), rs.getString("uf_pes"));
                lista.add(m_objpes);
            }
            Dao.closeConnection(this.Con, stm, rs);
            return lista;
        } catch (Exception e) {
            throw new Exception("Erro:" + e.getMessage());
        }
    }

    public int checa_cpf_pessoa_outra(String cod_pes,String cpf_pes) throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());
            Statement stm = (Statement) this.Con.createStatement();
            ResultSet rs = stm.executeQuery("select count(cpf_pes) FROM pessoa where cpf_pes="+cpf_pes+" and cod_pes !="+ cod_pes);

            while (rs.next()) {
                validacao = rs.getInt("count(cpf_pes)");
            }
            Dao.closeConnection(this.Con, stm, rs);
            return validacao;
        } catch (Exception e) {
            throw new Exception("Erro:" + e.getMessage());
        }
    }
    
    public int checa_cpf_pessoa(String cpf_pes) throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());
            Statement stm = (Statement) this.Con.createStatement();
            ResultSet rs = stm.executeQuery("select count(cpf_pes) FROM pessoa where cpf_pes=" + cpf_pes);

            while (rs.next()) {
                validacao = rs.getInt("count(cpf_pes)");
            }
            Dao.closeConnection(this.Con, stm, rs);
            return validacao;
        } catch (Exception e) {
            throw new Exception("Erro:" + e.getMessage());
        }
    }

    public void insere_pessoa(M_pessoa m_objpes) throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());
            String query = "insert into pessoa (nome_pes,cpf_pes,data_pes,peso_pes,uf_pes) values (?,?,?,?,?)";

            PreparedStatement stm = (PreparedStatement) this.Con.prepareStatement(query);

            stm.setString(1, m_objpes.getNome_pes());
            stm.setString(2, m_objpes.getCpf_pes());
            stm.setString(3, m_objpes.getData_pes());
            stm.setString(4, m_objpes.getPeso_pes());
            stm.setString(5, m_objpes.getUf_pes());
            stm.executeUpdate();
            Dao.closeConnection(this.Con, stm);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro:" + e.getMessage());
        }
    }
    
    public void altera_pessoa(M_pessoa m_objpes) throws Exception {
        try {
            this.Con = ((Connection) Dao.getConnection());            
            String query = "update pessoa set nome_pes=?,cpf_pes=?,data_pes=?,peso_pes=?,uf_pes=? where cod_pes=?";

            PreparedStatement stm = (PreparedStatement) this.Con.prepareStatement(query);

            
            stm.setString(1, m_objpes.getNome_pes());
            stm.setString(2, m_objpes.getCpf_pes());
            stm.setString(3, m_objpes.getData_pes());
            stm.setString(4, m_objpes.getPeso_pes());
            stm.setString(5, m_objpes.getUf_pes());
            stm.setString(6, m_objpes.getCod_pes()+"");
            stm.executeUpdate();
            Dao.closeConnection(this.Con, stm);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erro:" + e.getMessage());
        }
    }
    
public void deleta_pessoa(String cod_pes) throws Exception
{
try {
this.Con = ((Connection)Dao.getConnection());
String query = "delete from pessoa where cod_pes="+cod_pes;
PreparedStatement stm = (PreparedStatement)this.Con.prepareStatement(query);

stm.executeUpdate();
Dao.closeConnection(this.Con, stm);
} catch (Exception e) {
e.printStackTrace();
throw new Exception("Erro:" + e.getMessage());
}
}
    
}
