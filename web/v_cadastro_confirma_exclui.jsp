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
//Adicionando as classes de Conexão\Modelo\Controle e criando o Objeto Pessoa
C_pessoa c_objpes = new C_pessoa();

String cod_pes = "";

//variável recebe o parametro com o código da pessoa que vai ser excluida
if(request.getParameter("cod_pes")!=null){
	//Variável recebe o Post
	 cod_pes = request.getParameter("cod_pes");
}
//Se este parametro estiver setado é feita a exclusão do cadastrdo da Pessoa
if(cod_pes!=null){
//O cadastro é excluido da base
c_objpes.deleta_pessoa(cod_pes);
//Após a exclusão é direcionado para a pagina inicial com a mensagem de Cadastro excluido com sucesso
out.print("<script>window.location.href = 'index.jsp?ret=1&msg=2';</script>");
}
%>
