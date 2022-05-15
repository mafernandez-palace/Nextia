using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AD;
using INFO;
using System.IO;
using System.Configuration;

namespace FeatureEugenia2022
{
    public partial class _Default : Page
    {
        private readonly ClsConexionAD conAD = new ClsConexionAD();
        protected void Page_Load(object sender, EventArgs e)
        {
            //INFO vacío para cargar a todos los usuarios en el postback
             List< INFO.Reporte_Invitaciones> LstInvitaciones = new List<INFO.Reporte_Invitaciones>();

            //SE valida si existe un login para cargar TODOS LAS INVITACIONES AL POSTBACK, SE DEBE CONSIDERAR QUE SI ES UNA TABLA DE MUCHOS REGISTROS QUE SE CARGUEN LOS PRIMEROS 100 REGISTROS O SEGÚN LA PÁGINA
            if (!IsPostBack) {

                string _usuario = Session["_usuario"] as string;

                if (_usuario != "" && !(_usuario is null)) //si existe sesion se listan las invitaciones
                {

                    pnlLogin.Visible = false;
                    PnlListaInvitaciones.Visible = true;

                    conAD.iniCon(ConfigurationManager.ConnectionStrings["Conectar"].ConnectionString);

                    int intId = 0;
                    intId = (txtId.Text.Length == 0) ? 0 : Convert.ToInt32(txtId.Text); //validación en caso de estar vacío el campo

                    LstInvitaciones = conAD.ListaInvitaciones(intId, txtNombres.Text);//q traiga todos los usuarios

                    //se crea el encabezado
                    CrearEncabezadoTablaEmp();

                    //llenar la tabla
                    CrearContenidoTablaEmp(LstInvitaciones);
                }
                else 
                {
                    pnlLogin.Visible = true;
                    PnlListaInvitaciones.Visible = false;
                }
            }
        }

        protected void btnEntrar_Click(object sender, EventArgs e) 
        {
            INFO.Usuarios ObjUsuario = new INFO.Usuarios();
            conAD.iniCon(ConfigurationManager.ConnectionStrings["Conectar"].ConnectionString);

            ObjUsuario = conAD.BuscaUsuario(txtEmail.Text, txtPass.Text);

            if (ObjUsuario.ID > 0)
            {
                Session["_usuario"] = ObjUsuario.Email;
                Session["_usuarioId"] = ObjUsuario.ID;

                pnlLogin.Visible = false;
                PnlListaInvitaciones.Visible = true;

                Response.Redirect("Default.aspx");

            }
            else 
            {

                lblMsg.CssClass = "alert-info";
                lblMsg.Text = "No se encuentra usuario, verifique su email o su contraseña";

            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            List<INFO.Reporte_Invitaciones> LstInvitaciones = new List<INFO.Reporte_Invitaciones>();

            //SE BUSCAN SEGÚN PARÁMETROS 
            conAD.iniCon(ConfigurationManager.ConnectionStrings["Conectar"].ConnectionString);
            
            int intId = 0;
            intId = (txtId.Text.Length == 0) ? 0 : Convert.ToInt32(txtId.Text); //validación en caso de estar vacío el campo
            
            LstInvitaciones = conAD.ListaInvitaciones(intId, txtNombres.Text);

            //se crea el encabezado
            CrearEncabezadoTablaEmp();

            //llenar la tabla
            CrearContenidoTablaEmp(LstInvitaciones);

        }

        private void CrearEncabezadoTablaEmp() 
        {
            //llenar la tabla con el encabezado
            TableRow Fila = new TableRow();
            TableCell Celda = new TableCell();

            tblInvitaciones.Rows.Clear();

            Celda.Text = "Id Invitación";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Nombre Invitación";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Nombre Usuario";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Núm.Depto.";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Email";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Fecha Entrada";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);

            Celda = new TableCell();
            Celda.Text = "Fecha Caducidad";
            Celda.CssClass = "table-primary";
            Fila.Cells.Add(Celda);
            
            Fila.CssClass="table-primary";
            tblInvitaciones.Rows.Add(Fila); //se agrega la fila a la tabla

        }

        private void CrearContenidoTablaEmp(List<Reporte_Invitaciones> LstInvitados)
        {

            foreach (Reporte_Invitaciones ObjInvitacion in LstInvitados)
            {

                TableRow Fila = new TableRow();
                TableCell Celda = new TableCell();

                //Celda.Text = "<a href=javascript:EditarEmpleado('" + ObjInvitacion.ID.ToString() + "')>" + ObjInvitacion.ID.ToString() + "</a>";
                //Fila.Cells.Add(Celda);

                Celda.Text = ObjInvitacion.INV_ID.ToString();
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.INV_Nombre;
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.Nombres + " " + ObjInvitacion.ApePat + " " + ObjInvitacion.ApeMat;
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.NumDepto.ToString();
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.Email;
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.FechaHoraEntrada.ToString("dd/MM/yyyy");
                Fila.Cells.Add(Celda);

                Celda = new TableCell();
                Celda.Text = ObjInvitacion.FechaHoraCaducidad.ToString("dd/MM/yyyy");
                Fila.Cells.Add(Celda);

                tblInvitaciones.Rows.Add(Fila); //se agrega la fila a la tabla
            }


        }

        protected void btnCrearInvitacion_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Usuario.aspx?Invitacion=true");
        }

        protected void btnNuevoUsuario_Click(object sender, EventArgs e)
        {
            Response.Redirect("Usuario.aspx?");
        }
    }
}