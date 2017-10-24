package Model;

public class M_pessoa {

    int cod_pes;
    String nome_pes;
    String cpf_pes;
    String data_pes;
    String peso_pes;
    String uf_pes;

    public M_pessoa() {
    }
    
    public M_pessoa(int cod_pes, String nome_pes, String cpf_pes, String data_pes, String peso_pes, String uf_pes) {
        this.cod_pes = cod_pes;
        this.nome_pes = nome_pes;
        this.cpf_pes = cpf_pes;
        this.data_pes = data_pes;
        this.peso_pes = peso_pes;
        this.uf_pes = uf_pes;
    }

    public int getCod_pes() {
        return cod_pes;
    }

    public void setCod_pes(int cod_pes) {
        this.cod_pes = cod_pes;
    }

    public String getNome_pes() {
        return nome_pes;
    }

    public void setNome_pes(String nome_pes) {
        this.nome_pes = nome_pes;
    }

    public String getCpf_pes() {
        return cpf_pes;
    }

    public void setCpf_pes(String cpf_pes) {
        this.cpf_pes = cpf_pes;
    }

    public String getData_pes() {
        return data_pes;
    }

    public void setData_pes(String data_pes) {
        this.data_pes = data_pes;
    }

    public String getPeso_pes() {
        return peso_pes;
    }

    public void setPeso_pes(String peso_pes) {
        this.peso_pes = peso_pes;
    }

    public String getUf_pes() {
        return uf_pes;
    }

    public void setUf_pes(String uf_pes) {
        this.uf_pes = uf_pes;
    }
}
