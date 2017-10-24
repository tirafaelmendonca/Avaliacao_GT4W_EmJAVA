<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>GT4W - Em JAVA</title>
        <!-- Adicionando arquivos CSS-->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/gt4w.css" rel="stylesheet">
        <!-- Adicionando arquivos Javascript BootStrap e Jquery-->
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/jquery.cookie.js"></script>
        <script type="text/javascript" src="js/jquery.js"></script>
        <script>
            //Validador de CPF
            //Se o cpf for validado ele mostra uma imagem verde que mostra que está tudo certo 
            window.onload = verificarCPF(c);
            function verificarCPF(c) {
                image = document.getElementById('img_valida');
                cpf_pes = document.getElementById('cpf_pes');
                button = document.getElementById('button');
                button.disabled = true;
                var i;
                s = c;

                if (s != '111.111.111-11') {
                    if (s != '222.222.222-22') {
                        if (s != '333.333.333-33') {
                            if (s != '444.444.444-44') {
                                if (s != '555.555.555-55') {
                                    if (s != '666.666.666-66') {
                                        if (s != '777.777.777-77') {
                                            if (s != '888.888.888-88') {
                                                if (s != '999.999.999-99') {

                                                    var c1 = s.substr(0, 3);
                                                    var c2 = s.substr(4, 3);
                                                    var c3 = s.substr(8, 3);

                                                    var c = c1 + c2 + c3;
                                                    var dv = s.substr(12, 2);
                                                    var d1 = 0;
                                                    var v = false;

                                                    for (i = 0; i < 9; i++) {
                                                        d1 += c.charAt(i) * (10 - i);
                                                    }
                                                    if (d1 == 0) {
                                                        image.src = 'img/invalid.png';
                                                        cpf_pes.focus();
                                                        v = true;
                                                        return false;
                                                        button.disabled = true;
                                                    }
                                                    d1 = 11 - (d1 % 11);
                                                    if (d1 > 9)
                                                        d1 = 0;
                                                    if (dv.charAt(0) != d1) {
                                                        image.src = 'img/invalid.png';
                                                        cpf_pes.focus();
                                                        v = true;
                                                        return false;
                                                        button.disabled = true;
                                                    }

                                                    d1 *= 2;
                                                    for (i = 0; i < 9; i++) {
                                                        d1 += c.charAt(i) * (11 - i);
                                                    }
                                                    d1 = 11 - (d1 % 11);
                                                    if (d1 > 9)
                                                        d1 = 0;
                                                    if (dv.charAt(1) != d1) {
                                                        image.src = 'img/invalid.png';
                                                        cpf_pes.focus();
                                                        v = true;
                                                        return false;
                                                        button.disabled = true;
                                                    }
                                                    if (!v) {
                                                        image.src = 'img/valid.png';
                                                        button.disabled = false;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        </script>
    </head>
    <body>
        <!--
        Nesta área é feita a consulta ao Webservice do geonames para que seja utilizado os dados de Estado
        É feita um resgate da escolha anterior no caso de um cookie existir
        -->
        <%

            String nome_pes = "";
            String cpf_pes = "";
            String data_pes = "";
            String peso_pes = "";
            String uf_pes = "00";
            String Tuf_pes = "";

            Charset UTF_8 = StandardCharsets.UTF_8;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equalsIgnoreCase("nome_pes")) {
                        byte[] bnome_pes = Base64.getDecoder().decode(cookie.getValue().getBytes(UTF_8));
                        nome_pes = new String(bnome_pes, "UTF-8");
                    }
                    if (cookie.getName().equalsIgnoreCase("cpf_pes")) {
                        byte[] bcpf_pes = Base64.getDecoder().decode(cookie.getValue().getBytes(UTF_8));
                        cpf_pes = new String(bcpf_pes, "UTF-8");
                    }
                    if (cookie.getName().equalsIgnoreCase("data_pes")) {
                        byte[] bdata_pes = Base64.getDecoder().decode(cookie.getValue().getBytes(UTF_8));
                        data_pes = new String(bdata_pes, "UTF-8");
                    }
                    if (cookie.getName().equalsIgnoreCase("peso_pes")) {
                        byte[] bpeso_pes = Base64.getDecoder().decode(cookie.getValue().getBytes(UTF_8));
                        peso_pes = new String(bpeso_pes, "UTF-8");
                    }
                    if (cookie.getName().equalsIgnoreCase("uf_pes")) {
                        byte[] buf_pes = Base64.getDecoder().decode(cookie.getValue().getBytes(UTF_8));
                        uf_pes = new String(buf_pes, "UTF-8");
                    }
                }
            }
        %>
        <script type="text/javascript" >
            $.ajax({
                url: "http://www.geonames.org/childrenJSON?geonameId=3469034",
                dataType: "json",
                type: "get",
                cache: false,
                success: function (data) {
                    //Este laço percorre por toda a extensão do objeto json obtido no webservice
                    $(data.geonames).each(function (index, value) {
                        //Nesta área é testado se (adminCode1) que é a identificação de cada estado no WS for igual os estado cadastrado insere um 
                        //option na caixa de seleção de estados já selecionada 
            <%
                                    if (uf_pes != null) {
                                        Tuf_pes = "'" + uf_pes + "'";
            %>
                        if (value.adminCode1 ===<%=Tuf_pes%>) {
                            if (value.adminCode1 === '07') {
                                //Se não for igual ao cadastrado e for igual a 07 é feito um tratamento(o Distrito Federal está em Inglês) e é acrscentado um option na caixa de seleção
                                $('select').append('<option selected value=' + value.adminCode1 + '>Distrito Federal</option>');
                            } else {
                                $('select').append('<option selected value=' + value.adminCode1 + '>' + value.toponymName + '</option>');
                            }
                        }// Para os demais é acrscentado um option na caixa de seleção
                        else {
                        if (value.adminCode1 === '07') {
                            //Se não for igual ao cadastrado e for igual a 07 é feito um tratamento(o Distrito Federal está em Inglês) e é acrscentado um option na caixa de seleção
                            $('select').append('<option value=' + value.adminCode1 + '>Distrito Federal</option>');
                        } else {
                            $('select').append('<option value=' + value.adminCode1 + '>' + value.toponymName + '</option>');
                        }
                        }
            <%
                                } else {
            %>
                        //Se não for igual ao cadastrado e for igual a 07 é feito um tratamento(o Distrito Federal está em Inglês) e é acrscentado um option na caixa de seleção
                        if (value.adminCode1 === '07') {
                            //Se não for igual ao cadastrado e for igual a 07 é feito um tratamento(o Distrito Federal está em Inglês) e é acrscentado um option na caixa de seleção
                            $('select').append('<option value=' + value.adminCode1 + '>Distrito Federal</option>');
                        } else {
                            $('select').append('<option value=' + value.adminCode1 + '>' + value.toponymName + '</option>');
                        }
            <%
                                    }%>
                    });
                }
            });
        </script>
        <div class="container">
            <form class="gt4w" name="pedido" method="POST" action='v_cadastro_confirma.jsp'>
                <!--Topo da tela-->
                <a href="index.jsp"><img src="img/gt4w.png"  alt="Gt4W"></a> 
                <br>
                <label id="label">Avaliação Técnica 20/10/2017</label>
                <br>
                <label id="label">Cadastro de Pessoas</label>
                <br>
                <label id="label">Novo Cadastro - (*) Campos Obrigatórios!</label>
                <br>
                <a href='index.jsp'><img src="img/voltar.png" height="32" width="32"></a>
                <br>
                <!--Nesta área é recebido um parametro por GET.
            Se ele for setado é apresentado uma Mensagem conforme o parametro msg que vem por GET.
                -->
                <%
                    String img = "";
                    String Gret = "0";
                    String Gmsg = "0";
                    Gret = request.getParameter("ret");
                    Gmsg = request.getParameter("msg");
                    if (Gret != null) {
                        if (Gmsg != null) {
                %>
                <script>
                    //Fecha o alerta após alguns segundos
                    window.setTimeout(function () {
                        $(".alert").fadeTo(500, 0).slideUp(500, function () {
                            $(this).remove();
                        });
                    }, 4000);
                </script>

                <%
                    if (Gmsg.equalsIgnoreCase("1")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Este CPF já está em uso!</div>
                <%                     } else if (Gmsg.equalsIgnoreCase("2")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Revise a data, fevereiro somente até 28 ou 29!</div>
                <%                      } else if (Gmsg.equalsIgnoreCase("2")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Revise a data, dia máximo é 31 para esta mês!</div>
                <%                            } else if (Gmsg.equalsIgnoreCase("3")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Revise a data, dia máximo é 31 para esta mês!</div>
                <%                            } else if (Gmsg.equalsIgnoreCase("4")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Revise a data, dia máximo é 30 para esta mês!</div>
                <%                            } else if (Gmsg.equalsIgnoreCase("5")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Revise a data, mês inexistente!</div>
                <%                            } else if (Gmsg.equalsIgnoreCase("6")) {
                %>
                <div id='msg' disabled class="alert alert-danger">Erro ao Inserir!</div>
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
                        img = "valid";
                    } else {
                        img = "invalid";
                    }

                %>
                <label id="label">Nome (*)</label>		
                <input type="text" id="input" name='nome_pes' class="form-control" placeholder="Digite seu nome"  value='<%=nome_pes%>' required autofocus>

                <label id="label">CPF (*)</label>
                <img id='img_valida' src="img/<%=img%>.png">
                <input type="text" id="cpf_pes" name='cpf_pes' maxlength="14" class="form-control" placeholder="999.999.999-99" data-mask="000.000.000-00" pattern="\d{3}\.\d{3}\.\d{3}-\d{2}" value='<%=cpf_pes%>' onblur="return verificarCPF(this.value)" required>

                <label id="label">Data de Nascimento</label>
                <input type="text" id="data_pes" name='data_pes' maxlength="10" class="form-control" placeholder="DD/MM/YYYY" data-mask="00/00/0000"  pattern="[0-9]{2}\/[0-9]{2}\/[0-9]{4}$" value='<%=data_pes%>'>

                <label id="label">Peso (Kg)</label>
                <input type="text" id="peso_pes" name='peso_pes'class="form-control" placeholder="0,000" data-mask-reverse="true" data-mask="009,999"" value='<%=peso_pes%>'>

                <label id="label">Estado</label>
                <br>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <select id='select' name='uf_pes' class="selectpicker form-control">
                                <option selected >Escolha o Estado</option>
                            </select>
                        </div>
                    </div>
                </div>		
                <button id='button' type="submit" class="btn btn-primary">Cadastrar</button>
            </form>
        </div>
        <!-- Adicionando arquivos Javascript responsável pelas Mascaras-->
        <script type="text/javascript" src="js/jquery.mask.js"></script>
    </body>
</html>

