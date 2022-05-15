using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AD;
using INFO;
using System.Configuration;
using System.Security.Policy;
using System.Web.SessionState;
using System.Globalization;
using System.IO;
using System.Drawing;
using MessagingToolkit.QRCode.Codec;

namespace FeatureEugenia2022
{
    public partial class Contact : Page
    {
        private readonly ClsConexionAD conAD = new ClsConexionAD();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string _usuario = (string)Session["_usuario"];
                string _invitacion = "";
                if (_usuario != "" && !(_usuario is null))
                {
                    _invitacion = Request.QueryString["Invitacion"];
                    
                    PnlInvitacion.Visible = true;
                    PnlUsuario.Visible = false;

                    lblTitPagina.Text = "Genera invitaciones";

                    lblMsg.CssClass = "alert-success";
                    lblMsg.Text = "";

                    iniCon(); //inicializa conexion
                }
                else 
                {
                    PnlInvitacion.Visible = false;
                    PnlUsuario.Visible = true;
                    lblTitPagina.Text = "Datos de usuario";
                }

            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            INFO.Usuarios ObjUsuarios = new INFO.Usuarios();
            try
            {
                ObjUsuarios.Nombres = txtNombre.Text;
                ObjUsuarios.ApePat = txtApePat.Text;
                ObjUsuarios.ApeMat = txtApeMat.Text;
                ObjUsuarios.Email = txtEmail.Text;
                ObjUsuarios.NumDepto = Convert.ToInt32(txtNumDepto.Text);
                ObjUsuarios.Contrasenia = txtContrasenia.Text;

                //validando contraseña
                if (txtContrasenia.Text == txtConfirmaPass.Text)
                {

                    iniCon(); //inicializa conexion

                    int sSuccess = 0;
                    string MsgErr = "";

                    conAD.UsuariosCRUD(ObjUsuarios, ref sSuccess, ref MsgErr);

                    if (sSuccess > 0)
                    {
                        Session["_usuario"] = ObjUsuarios.Email;
                        lblMsg.CssClass = "alert-success";
                        lblMsg.Text = "Los cambios se han guardado correctamente";
                    }
                    else
                    {
                        lblMsg.CssClass = "alert-info";
                        lblMsg.Text = MsgErr;
                    }


                    Response.Redirect("Default.aspx");

                }
                else
                {
                    lblMsg.CssClass = "alert-info";
                    lblMsg.Text = "La contraseña no es igual a su confirmación, favor de corregirlo para crear el nuevo usuario.";
                }


            }
            catch (Exception ex)
            {
                lblMsg.CssClass = "alert-danger";
                lblMsg.Text = ex.Message.ToString();
            }
            //falta generar notificaciones

        }

        private void iniCon()
        {
            conAD.iniCon(ConfigurationManager.ConnectionStrings["Conectar"].ConnectionString);
        }


        protected void btnCrearInv_Click(object sender, EventArgs e)
        {
            //falta hacer validaciones de fechas de nacimiento para el alta y mod
            INFO.Invitaciones ObjInv = new INFO.Invitaciones();
            try
            {
                if (cldFechaEntrada.SelectedDate.Year > 1 && cldFechaCaducidad.SelectedDate.Year > 1)
                {


                    ObjInv.Nombre = txtNombreInv.Text;
                    ObjInv.USU_Id = Convert.ToInt32(Session["_usuarioId"]);
                    ObjInv.FechaHoraEntrada = cldFechaEntrada.SelectedDate;
                    ObjInv.FechaHoraCaducidad = cldFechaCaducidad.SelectedDate;

                    iniCon(); //inicializa conexion

                    int sSuccess = 0;
                    string MsgErr = "";

                    conAD.CreaInvitacion(ObjInv, ref sSuccess, ref MsgErr);

                    if (sSuccess > 0)
                    {
                        //se llama a crear el QR
                        generarQR(ObjInv.Nombre);

                        lblMsg.CssClass = "alert-success";
                        lblMsg.Text = "Los cambios se han guardado correctamente";

                    }
                    else
                    {
                        lblMsg.CssClass = "alert-info";
                        lblMsg.Text = MsgErr;
                    }

                }
                else 
                {

                    lblMsg.CssClass = "alert-danger";
                    lblMsg.Text = "Seleccione las fechas de entrada y caducidad";
                }

            }
            catch (Exception ex)
            {
                lblMsg.CssClass = "alert-danger";
                lblMsg.Text = ex.Message.ToString();
            }
        }

        public void generarQR(string NombreInvitacion)
        {
            QRCodeEncoder encoder = new QRCodeEncoder();
            Bitmap img = encoder.Encode(NombreInvitacion);
            System.Drawing.Image QR = (System.Drawing.Image)img;

            using (MemoryStream ms = new MemoryStream())
            {
                QR.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();
                imgQR.Src = "data:image/gif;base64," + Convert.ToBase64String(imageBytes);
                imgQR.Height = 200;
                imgQR.Width = 200;
            }

        }

    }
}