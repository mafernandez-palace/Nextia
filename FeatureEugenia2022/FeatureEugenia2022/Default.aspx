<%@ Page Title="Nextia Exam" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FeatureEugenia2022._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"> 
    <div class="container">
        <asp:Panel ID="pnlLogin" runat="server">
            <div class="jumbotron">
            <p class="lead">Login</p>
                <div class="row">
                    <asp:label runat="server" ID="lblMsg"  Width="600px" CssClass="alert-success" ></asp:label>
                </div>
                <br />
                <div class="row">
                    <table>
                        <tr>
                            <td colspan="2">
                                <div class="col-xs-12 col-sm-12 col-md-3">
                                    <span>Email:</span> 
                                    <br />
                                    <asp:TextBox runat="server" ID="txtEmail" MaxLength="100" Width="300px"></asp:TextBox>
                                    <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revEmail" Display="Dynamic" ValidationExpression="^[^@]+@[^@]+\.[a-zA-Z]{2,}$" ControlToValidate="txtEmail" Text="Correo electrónico inválido"></asp:RegularExpressionValidator></div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="col-xs-12 col-sm-12 col-md-3">
                                    <span>Contraseña:</span> 
                                    <br />
                                    <asp:TextBox runat="server" ID="txtPass" TextMode="Password" MaxLength="100" Width="300px"></asp:TextBox>
                                    <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revPass" Display="Dynamic" ValidationExpression="[A-Za-z0-9\s]*" ControlToValidate="txtPass" Text="Correo electrónico inválido"></asp:RegularExpressionValidator></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <div class="row">
                    <table>
                        <tr>
                            <td>
                                <div class="col-xs-12 col-sm-12 col-md-1"><asp:Button runat="server" ID="btnEntrar" Text="Entrar" class="btn btn-success btn-lg" OnClick="btnEntrar_Click" /></div>
                            </td>
                            <td>
                                <div class="col-xs-12 col-sm-12 col-md-1"><asp:Button runat="server" ID="btnNuevoUsuario" Text="Nuevo usuario" class="btn-link" OnClick="btnNuevoUsuario_Click" /></div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </asp:Panel>
        <asp:Panel ID="PnlListaInvitaciones" runat="server" Visible="false">
        <div class="jumbotron">
            <h2>Feature Eugenia 2022 - Exam Ma.Danilú Fdz G.</h2>
            <br />
            <div class="left">
                <div class="col-xs-12 col-sm-12 col-md-1"></div>
                    
            </div>
            <br />
            <asp:Button runat="server" ID="btnCrearInvitacion" Text="Crear invitación" class="btn-sucess" OnClick="btnCrearInvitacion_Click1" />
            <br />
            <br />
            <p class="lead">Lista de Invitados</p>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3">
                    <span>Id Invitación:</span> 
                    <asp:TextBox runat="server" ID="txtId" MaxLength="50" Width="50px"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="col"><asp:RegularExpressionValidator runat="server" CssClass="alert-danger" ID="revBus" Display="Dynamic" ValidationExpression="[0-9]*" ControlToValidate="txtId" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3">
                    <span>Nombre(invitación o usuario)</span> 
                    <asp:TextBox runat="server" ID="txtNombres" MaxLength="100" Width="300px"></asp:TextBox>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col"><asp:RegularExpressionValidator runat="server" ID="RevNombres" CssClass="alert-danger" Display="Dynamic" ValidationExpression="[A-Za-z0-9\s]*" ControlToValidate="txtNombres" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-1"><asp:Button runat="server" ID="btnBuscar" Text="Buscar" class="btn btn-success btn-lg" OnClick="btnBuscar_Click" /></div>
            </div>
        </div>
        <div Class="table-responsive table-striped">
            <asp:Table runat="server" ID="tblInvitaciones" CssClass="table"></asp:Table>
        </div>
        </asp:Panel>
    </div>
    
</asp:Content>
