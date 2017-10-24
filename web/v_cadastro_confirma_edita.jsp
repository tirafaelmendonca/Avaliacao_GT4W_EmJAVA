<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="java.net.HttpCookie"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DateFormat"%>
<!--Adicionando as classes de Conexão\Modelo\Controle e criando o Objeto Pessoa-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Controller.C_pessoa"%>
<%@page import="Model.M_pessoa"%> 
<%
C_pessoa c_objpes = new C_pessoa();

//Criação de variáveis
String cod_pes ="";
String nome_pes ="";
String cpf_pes = "";
String data_pes = "";
String peso_pes = "";
String uf_pes = "";
int validacao = 0;
int dia;
int mes;
int ano;

Charset UTF_8 = StandardCharsets.UTF_8;

//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("cod_pes")!=null){
	//Variável recebe o Post
	 cod_pes = request.getParameter("cod_pes");
         //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
         String cod_pes64 = Base64.getEncoder().encodeToString(nome_pes.getBytes(UTF_8));
         Cookie cookieCod_pes = new Cookie("cod_pes",cod_pes64);
         response.addCookie(cookieCod_pes);
}

//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("nome_pes")!=null){
	//Variável recebe o Post
	 nome_pes = request.getParameter("nome_pes");
         //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
         String nome_pes64 = Base64.getEncoder().encodeToString(nome_pes.getBytes(UTF_8));
         Cookie cookieNome_pes = new Cookie("nome_pes",nome_pes64);
         response.addCookie(cookieNome_pes);
}

//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("data_pes")!=null){
	//É feito a conversão de Data para o padrão Americano
	 data_pes = request.getParameter("data_pes");
         //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
         String data_pes64 = Base64.getEncoder().encodeToString(data_pes.getBytes(UTF_8));
         Cookie cookieData_pes = new Cookie("data_pes",data_pes64);
         response.addCookie(cookieData_pes);
	
	//Tratamento de datas validas
        if(data_pes.length()==10){
        dia = Integer.parseInt(data_pes.substring(0,2));       
        mes = Integer.parseInt(data_pes.substring(3,5));       
        ano = Integer.parseInt(data_pes.substring(6,10));     
        
	if((dia >29) && mes==2){
		validacao = 1;
		out.print("<script>window.location.href = 'v_cadastro_novo.jsp?ret=1&msg=2&cod_pes="+cod_pes+"';</script>");
	}else if(dia >31 && (mes==1 ||mes==3 ||mes==5 ||mes==7 || mes==8 ||mes==10 ||mes==12)){
		validacao = 1;
                out.print("<script>window.location.href = 'v_cadastro_edita.jsp?ret=1&msg=3&cod_pes="+cod_pes+"';</script>");
	}else if(dia >30 && (mes==4 || mes==6 || mes==9 ||mes==11)){
		validacao = 1;
		out.print("<script>window.location.href = 'v_cadastro_edita.jsp?ret=1&msg=4&cod_pes="+cod_pes+"';</script>");
	}else if(mes>12){
		validacao = 1;
                out.print("<script>window.location.href = 'v_cadastro_edita.jsp?ret=1&msg=5&cod_pes="+cod_pes+"';</script>");
	}
        data_pes = ano+"-"+mes+"-"+dia;
        }

}
//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("peso_pes")!=null){
        peso_pes = request.getParameter("peso_pes");
        //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
         String peso_pes64 = Base64.getEncoder().encodeToString(peso_pes.getBytes(UTF_8));
         Cookie cookiePeso_pes = new Cookie("peso_pes",peso_pes64);
         response.addCookie(cookiePeso_pes);
	//É retirado os pontos para gravar na base
	peso_pes = peso_pes.replace(",", "");
}

//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("uf_pes")!=null){
        //Variável recebe o Post
	uf_pes = request.getParameter("uf_pes");	
        //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
        String uf_pes64 = Base64.getEncoder().encodeToString(uf_pes.getBytes(UTF_8));
        Cookie cookieUf_pes = new Cookie("uf_pes",uf_pes64);
        response.addCookie(cookieUf_pes);
	
}

//Checa se o a varival que veio pelo Post foi setada
if(request.getParameter("cpf_pes")!=null){
        //Variável recebe o Post
	cpf_pes = request.getParameter("cpf_pes");	
        //Seta um cookie com o valor para que possa ser utilizado novamente em caso de erro
        String cpf_pes64 = Base64.getEncoder().encodeToString(cpf_pes.getBytes(UTF_8));
        Cookie cookieCpf_pes = new Cookie("cpf_pes",cpf_pes64);
        response.addCookie(cookieCpf_pes);
	
	//É retirado os pontos e traço para gravar na base
	cpf_pes = cpf_pes.replace(".", "");
	cpf_pes = cpf_pes.replace("-", "");
	//Esta variável recebe o retorno da checagem se este cpf já está cadastrado
	int retorno;
        retorno = c_objpes.checa_cpf_pessoa_outra(cod_pes,cpf_pes);
	//Se ele já foi cadastrado é direcionado para a pagina de cadastro com a mensagem referente ao CPF que já foi cadastrado
	if(retorno != 0){
	validacao = 1;
	out.print("<script>window.location.href = 'v_cadastro_edita.jsp?ret=1&msg=1&cod_pes="+cod_pes+"';</script>");
	}
}


if(validacao == 0){
//Nesta área é criado um objeto com os dados que serão alterados na base
Model.M_pessoa m_objpes = new Model.M_pessoa();
m_objpes = new Model.M_pessoa(Integer.parseInt(cod_pes),nome_pes,cpf_pes,data_pes,peso_pes,uf_pes);
//O obejto é alterado na base
c_objpes.altera_pessoa(m_objpes);
//Após a alteração é direcionado para a pagina inicial com a mensagem de Cadastro alterado com sucesso
out.print("<script>window.location.href = 'index.jsp?ret=1&msg=3';</script>");
}else{
out.print("<script>window.location.href = 'v_cadastro_edita.jsp?ret=1&msg=6'&cod_pes="+cod_pes+"';</script>");
}
%>

