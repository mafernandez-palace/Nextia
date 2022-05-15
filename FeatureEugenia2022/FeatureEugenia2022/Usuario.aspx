<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="FeatureEugenia2022.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <div class="container">
        <h3 class="jumbotron"><asp:Label runat="server" ID="lblTitPagina">Datos de Usuario</asp:Label></h3>
        <div class="row">
                <asp:label runat="server" ID="lblMsg"  Width="600px" CssClass="alert-success" ></asp:label>
        </div>
        <br />
        <asp:Panel ID="PnlUsuario" runat="server" Visible="true">
            <div>
                <div class="row">
                        <span>Nombre:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:TextBox runat="server" ID="txtNombre" MaxLength="150" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="RegularExpressionValidator1" Display="Dynamic" ValidationExpression="[A-Za-z\s]*" ControlToValidate="txtNombre" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
                        <div class="col">
                            <asp:RequiredFieldValidator runat="server" ID="rfvNombre" Display="Dynamic" CssClass="alert-danger" ControlToValidate="txtNombre" Text="El nombre del usuario es indispensable"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <span>Primer Apellido:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">                    
                        <asp:TextBox runat="server" ID="txtApePat" MaxLength="75" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revApePat" Display="Dynamic" ValidationExpression="[A-Za-z\s]*" ControlToValidate="txtApePat" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
                        <div class="col">
                                <asp:RequiredFieldValidator runat="server" ID="rfvApp" CssClass="alert-danger" Display="Dynamic" ControlToValidate="txtApePat" Text="El primer apellido del usuario es indispensable"></asp:RequiredFieldValidator>
                        </div> 
                    </div>
                </div>
                <br />
                <div class="row">
                    <span>Segundo Apellido:</span>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">                    
                        <asp:TextBox runat="server" ID="txtApeMat" MaxLength="75" Width="600px"></asp:TextBox> 
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revApeMat" Display="Dynamic" ValidationExpression="[A-Za-z\s]*" ControlToValidate="txtApeMat" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
                </div>
                </div>
                 <br />
                <div class="row">
                    <span>Email:</span>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">                    
                        <asp:TextBox runat="server" ID="txtEmail" MaxLength="300" Width="600px"></asp:TextBox> 
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revEmail" Display="Dynamic" ValidationExpression="^[^@]+@[^@]+\.[a-zA-Z]{2,}$" ControlToValidate="txtEmail" Text="Correo electrónico inválido"></asp:RegularExpressionValidator></div>
                        <div class="col">
                            <asp:RequiredFieldValidator runat="server" ID="rfvEmail" CssClass="alert-danger" Display="Dynamic" ControlToValidate="txtEmail" Text="El correo electrónico del usuario es indispensable"></asp:RequiredFieldValidator>
                        </div> 
                    </div>
                </div>
                <br />
                <div class="row">
                    <span>Contraseña:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:TextBox runat="server" ID="txtContrasenia"  TextMode="Password" MaxLength="10" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revTel" Display="Dynamic" ValidationExpression="[A-Za-z0-9\s]*" ControlToValidate="txtContrasenia" Text="La contraseña es incorrecta"></asp:RegularExpressionValidator></div>
                        <div class="col">
                                <asp:RequiredFieldValidator runat="server" ID="rfv" CssClass="alert-danger" Display="Dynamic" ControlToValidate="txtContrasenia" Text="La contraseña es indispensable"></asp:RequiredFieldValidator>
                        </div> 
                    </div>
                </div>
                <div class="row">
                    <span>Confirma Contraseña:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:TextBox runat="server" ID="txtConfirmaPass"  TextMode="Password" MaxLength="10" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="RegularExpressionValidator2" Display="Dynamic" ValidationExpression="[A-Za-z0-9\s]*" ControlToValidate="txtContrasenia" Text="La confirmación de la contraseña es incorrecta"></asp:RegularExpressionValidator></div>
                        <div class="col">
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" CssClass="alert-danger" Display="Dynamic" ControlToValidate="txtConfirmaPass" Text="La confirmación de la  contraseña es indispensable"></asp:RequiredFieldValidator>
                        </div> 
                    </div>
                </div>
                <br />
                <div class="row">
                    <span>Núm. Departamento:</span>
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:TextBox runat="server" TextMode="Number" ID="txtNumDepto" MaxLength="1" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="revDepto" Display="Dynamic" ValidationExpression="[0-9]*" ControlToValidate="txtNumDepto" Text="El número del departamento debe ser numérico"></asp:RegularExpressionValidator></div>
                        <div class="col">
                                <asp:RequiredFieldValidator runat="server" ID="rfvDepto" CssClass="alert-danger" Display="Dynamic" ControlToValidate="txtNumDepto" Text="El núm. del departamento es indispensable"></asp:RequiredFieldValidator>
                        </div>                 
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-1"><asp:Button runat="server" ID="btnGuardar" Text="Guardar" class="btn btn-success btn-lg" OnClick="btnGuardar_Click"/></div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="PnlInvitacion" runat="server" Visible="true">
            <div>
                <div class="row">
                        <span>Nombre:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:TextBox runat="server" ID="txtNombreInv" MaxLength="150" Width="600px"></asp:TextBox>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-5">
                        <div class="col"><asp:RegularExpressionValidator CssClass="alert-danger" runat="server" ID="RegularExpressionValidator3" Display="Dynamic" ValidationExpression="[A-Za-z\s]*" ControlToValidate="txtNombre" Text="Caracter inválido"></asp:RegularExpressionValidator></div>
                        <div class="col">
                            <asp:RequiredFieldValidator runat="server" ID="rfvNombreInv" Display="Dynamic" CssClass="alert-danger" ControlToValidate="txtNombreInv" Text="El nombre del usuario es indispensable"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                        <span>Fecha de entrada:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:Calendar runat="server" ID="cldFechaEntrada"></asp:Calendar>
                    </div>
                </div>
                <br />
                <div class="row">
                        <span>Fecha de Caducidad:</span> 
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3">
                        <asp:Calendar runat="server" ID="cldFechaCaducidad"></asp:Calendar>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-1"><asp:Button runat="server" ID="btnCrearInv" Text="Guardar" class="btn btn-success btn-lg" OnClick="btnCrearInv_Click"/></div>
                </div>
                <img   runat="server" id="imgQR"/>
            </div>
        </asp:Panel>
    </div>   
    <input id="hdnIdEmp" name="hdnIdEmp" runat="server" type="hidden"/>
    <asp:ListBox runat="server" ID="lstSueldos" AutoPostBack="true" SelectionMode="Single" CssClass="hide"></asp:ListBox>
</asp:Content>
