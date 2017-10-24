<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <!-- Adicionando as classes de Conexão\Modelo\Controle e criando o Objeto Pessoa-->
    <%@page import="Controller.C_pessoa"%>
    <%@page import="Model.M_pessoa"%>  
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <head>
        <meta http-equiv="X-UA-Compatible" content="EmulateIE8" />
        <meta content='text/html; charset=UTF-8' http-equiv="Content-Type"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>GT4W - Em JAVA</title>
        <!-- Adicionando arquivos CSS-->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/gt4w.css" rel="stylesheet">
        <!-- Adicionando arquivos Javascript BootStrap e Jquery-->
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.mask.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="gt4w">

                <!--Topo da tela-->
                <img src="img/gt4w.png"  alt="Gt4W" width='200' height='80'> 
                <br>
                <label id="label">Avaliação Técnica 20/10/2017</label>
                <br>
                <label id="label">Cadastro de Pessoas</label>
                <br>
                <!--link para cadastro de novas Pessoas-->
                <a href="v_cadastro_novo.jsp" title="Novo pedido" ><img src="img/novo.png" height="32" width="32"></a>
                <!--Nesta área é recebido um parametro por GET.
                   Se ele for setado é apresentado uma Mensagem conforme o parametro msg que vem por GET.
                   Aqui também é feita a limpeza dos cookies utilizados no cadastro
                -->
                <%
                   
                    String Gret = "0";
                    String Gmsg = "0";
                    Gret = request.getParameter("ret");
                    Gmsg = request.getParameter("msg");
                    if (Gret != null) {
                        if (Gmsg != null) {
                %>
                <script>
                    window.setTimeout(function () {
                        $(".alert").fadeTo(500, 0).slideUp(500, function () {
                            $(this).remove();
                        });
                    }, 4000);
                </script>
                <%
                    if (Gmsg.equalsIgnoreCase("1")) {
                %>
                <div id='msg' disabled class="alert alert-success">Cadastro realizado com sucesso!</div>
                <%                     } else if (Gmsg.equalsIgnoreCase("2")) {
                %>
                <div id='msg' disabled class="alert alert-warning">Cadastro Deletado com sucesso!</div>
                <%                      } else if (Gmsg.equalsIgnoreCase("3")) {
                %>
                <div id='msg' disabled class="alert alert-info">Cadastro Alterado com sucesso!</div>
                <%                            }
                            Cookie cookieNome_pes = new Cookie("nome_pes", "");
                            response.addCookie(cookieNome_pes);
                            Cookie cookieCpf_pes = new Cookie("cpf_pes", "");
                            response.addCookie(cookieCpf_pes);
                            Cookie cookieData_pes = new Cookie("data_pes", "");
                            response.addCookie(cookieData_pes);
                            Cookie cookieUf_pes = new Cookie("uf_pes", "");
                            response.addCookie(cookieUf_pes);
                        }
                    }
                %>
                <!--Nesta área é criada um tabela com os dados das pessoas já cadastradas. Note que esta tabela não aparece em dispositivos pequenos.-->
                <table style='width:100%;' border="1" bordercolor="#D3D3D3" class="table hidden-xs">
                    <tr>
                        <td>Cod.</td>
                        <td>Nome</td>
                        <td>CPF</td>
                        <td>Data Nasc</td>
                        <td>Peso</td>
                        <td>Estado</td>
                        <td colspan='2' align='center'>Opções</td>
                    </tr>

                    <%
                        C_pessoa c_objpes = new C_pessoa();
                        List<M_pessoa> listapessoas = c_objpes.lista_pessoa();
                        int cod_pes;
                        String nome_pes;
                        String cpf_pes;
                        String data_pes;
                        String peso_pes;
                        double Dpeso_pes;
                        String uf_pes;
                        String dia;
                        String mes;
                        String ano;
                        String a;
                        String b;
                        String c;
                        String d;
                        for (int i = 0; i < listapessoas.size(); i++) {
                            cod_pes = listapessoas.get(i).getCod_pes();
                            nome_pes = listapessoas.get(i).getNome_pes();
                            
                            
                            
                            
                            cpf_pes = listapessoas.get(i).getCpf_pes();
                            a = cpf_pes.substring(0, 3);
                            b = cpf_pes.substring(3, 6);
                            c = cpf_pes.substring(6, 9);
                            d = cpf_pes.substring(9, 11);
                            cpf_pes = a + "." + b + "." + c + "-" + d;
                            data_pes = listapessoas.get(i).getData_pes();
                            ano = data_pes.substring(0, 4);
                            mes = data_pes.substring(5, 7);
                            dia = data_pes.substring(8, 10);
                            data_pes = dia + "/" + mes + "/" + ano;
                            peso_pes = listapessoas.get(i).getPeso_pes();
                            Dpeso_pes = Double.parseDouble(peso_pes) / 1000;
                            peso_pes = String.format("%.3f", Dpeso_pes);
                            uf_pes = listapessoas.get(i).getUf_pes();

                    %>
                    <tr>
                        <td><%=cod_pes%></td>
                        <td><%=nome_pes%></td>
                        <td><%=cpf_pes%></td>
                        <td><%=data_pes%></td>
                        <td><%=peso_pes%></td>
                        <td id='<%=cod_pes%>'></td>
                        <td><a href='v_cadastro_edita.jsp?cod_pes=<%=cod_pes%>'><img src='img/editar.png' height='32' width='32'></a></td>
                        <td><a href='#' data-href='v_cadastro_confirma_exclui.jsp?cod_pes=<%=cod_pes%>' data-toggle='modal' data-target='#confirm-delete'><img src='img/excluir.png' height='32' width='32'></a></td>
                    </tr>
                    <!--Nesta área é feita a consulta ao Webservice do geonames para que seja utilizado os dados de Estado-->
                    <script language="javascript">
                        $.ajax({
                            url: "http://www.geonames.org/childrenJSON?geonameId=3469034",
                            dataType: "json",
                            type: "get",
                            cache: false,
                            success: function (data) {
                                //Este laço percorre por toda a extensão do objeto json obtido no webservice
                                $(data.geonames).each(function (index, value) {
                                    //Nesta área é testado se (adminCode1) que é a identificação de cada estado no WS for igual os estado cadastrado
                                    //ele coloca o valor referênte ao nome do Estado (toponymName) no elemento html que possui o id igual ao código da pessoa
                                    if (value.adminCode1 == <%=uf_pes%>) {
                        <%
                            String id;
                            id = "'#" + cod_pes + "'";
                        %>
                                        if (value.adminCode1 === '07') {
                                            //Se não for igual ao cadastrado e for igual a 07 é feito um tratamento(o Distrito Federal está em Inglês) e é acrscentado um option na caixa de seleção
                                            $(<%=id%>).html("Distrito Federal");
                                        } else {
                                            $(<%=id%>).html(value.toponymName);
                                        }

                                    }
                                });
                            }
                        });
                    </script>
                    <%
                        }
                    %>
                </table>
                <!--Nesta área é criada a tabela que será apresentada nos dispositivos de tela pequena-->
                <table style='width:100%;' border="1" bordercolor="#D3D3D3"  class="table visible-xs">
                    <tr>
                        <td style='width:70%'>Nome</td>
                        <td style='width:30%' align='center' colspan='2'>Opções</td>
                    </tr>
                    <%   for (int x = 0; x < listapessoas.size(); x++) {
                            cod_pes = listapessoas.get(x).getCod_pes();
                            nome_pes = listapessoas.get(x).getNome_pes();
                            cpf_pes = listapessoas.get(x).getCpf_pes();
                            data_pes = listapessoas.get(x).getData_pes();
                            peso_pes = listapessoas.get(x).getPeso_pes();
                            uf_pes = listapessoas.get(x).getUf_pes();

                    %>
                    <tr>
                        <td><%=nome_pes%></td>
                        <td><a href='v_cadastro_edita.jsp?cod_pes=<%=cod_pes%>'><img src='img/editar.png' height='32' width='32'></a></td>
                        <td><a href='#' data-href='v_cadastro_confirma_exclui.jsp?cod_pes=<%=cod_pes%>' data-toggle='modal' data-target='#confirm-delete'><img src='img/excluir.png' height='32' width='32'></a></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <!--Nesta área é criada a janela Modal que pergunta se realmente deseja excluir o cadastro de uma Pessoa
                   Esta Modal é chamada pelo link que envia para a página de exclusão-->
                <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">Deseja excluir esta Pesssoa?</h4>
                            </div>
                            <div class="modal-footer">
                                <a class="btn btn-danger btn-ok">Delete</a>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Script que chama a Modal e acrescenta o caminho do link a ela-->
                <script language="javascript">
                    $('#confirm-delete').on('show.bs.modal', function (e) {
                        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
                        $('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-ok').attr('href') + '</strong>');
                    });
                </script>
            </div>
        </div>

    </body>
</html>

