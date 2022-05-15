using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FeatureEugenia2022
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string _usuario = Session["_usuario"] as string;
            if (_usuario != null && _usuario != "")
            {
                lnkInicio.InnerText = "Lista de invitaciones";
                lnkUsuarios.InnerText = "Genera Invitaciones";
            }

        }
    }
}