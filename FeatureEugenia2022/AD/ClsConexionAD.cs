using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Data;
using System.Reflection;
using INFO;
using System.Security.Cryptography.X509Certificates;
using System.Data.SqlClient;
using System.Runtime.InteropServices;

namespace AD
{
    public class ClsConexionAD
    {
        SqlConnection Con = new SqlConnection();

        public void iniCon(string sCadenaCon)
        {
            Con = new SqlConnection(sCadenaCon);
        }

        public void AbrirCon() {
            try
            {
                if (Con.State == ConnectionState.Closed)
                {
                    Con.Open();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public void CerrarCon()
        {
            if (Con.State == ConnectionState.Open)
            {
                Con.Close();
            }
        }

        public List<INFO.Reporte_Invitaciones> ListaInvitaciones(int ID_inv, string Nombre)
        {
    
            List<INFO.Reporte_Invitaciones> ListInvs = new List<Reporte_Invitaciones>();
            try
            {
                SqlDataReader LeeFilas;
                SqlCommand cmd = new SqlCommand("sp_FEAI_Invitaciones_Buscar", Con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID_inv);
                cmd.Parameters.AddWithValue("@Nombre", Nombre);
                cmd.Parameters.AddWithValue("@INV_FechaHoraInv", "");
                AbrirCon();

                LeeFilas = cmd.ExecuteReader();

                while (LeeFilas.Read())
                {
                    Reporte_Invitaciones objInvs = new INFO.Reporte_Invitaciones();

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("INV_Id"))) 
                    {
                        objInvs.INV_ID = Convert.ToInt32(LeeFilas[0]);
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("INV_Nombre")))
                    {
                        objInvs.INV_Nombre = LeeFilas[1].ToString();
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("USU_Nombres")))
                    {
                        objInvs.Nombres = LeeFilas[2].ToString();
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("USU_ApePat")))
                    {
                        objInvs.ApePat = LeeFilas[3].ToString();
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("USU_ApeMat")))
                    {
                        objInvs.ApeMat = LeeFilas[4].ToString();
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("USU_numDepto")))
                    {
                        objInvs.NumDepto = Convert.ToInt32(LeeFilas[5]);
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("USU_Email")))
                    {
                        objInvs.Email = LeeFilas[6].ToString();
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("INV_FechaHoraEntrada")))
                    {
                        objInvs.FechaHoraEntrada = Convert.ToDateTime(LeeFilas[7]);
                    }

                    if (!LeeFilas.IsDBNull(LeeFilas.GetOrdinal("INV_FechaHoraCaducidad")))
                    {
                        objInvs.FechaHoraCaducidad = Convert.ToDateTime(LeeFilas[8]);
                    }

                    ListInvs.Add(objInvs);

                }

                CerrarCon();
                LeeFilas.Close();

                return ListInvs;

            }        

            catch (Exception ex)
            {
                CerrarCon();
                return ListInvs;
                throw ex;
            }
        }

        public INFO.Usuarios BuscaUsuario(string Email, String Contrasenia) 
        {
            INFO.Usuarios objUsu = new INFO.Usuarios();
            try
            {
                SqlDataReader LeeFila;
                SqlCommand cmdABC = new SqlCommand("sp_FEAI_Usuario_Buscar", Con);
                cmdABC.CommandType = CommandType.StoredProcedure;

                cmdABC.Parameters.AddWithValue("@Email", Email);
                cmdABC.Parameters.AddWithValue("@Contrasenia", Contrasenia);

                AbrirCon();

                LeeFila = cmdABC.ExecuteReader();

                while (LeeFila.Read())
                {
                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_Id")))
                    {
                        objUsu.ID = Convert.ToInt32(LeeFila[0]);
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_Nombres")))
                    {
                        objUsu.Nombres = LeeFila[1].ToString();
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_ApePat")))
                    {
                        objUsu.ApePat = LeeFila[2].ToString();
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_ApeMat")))
                    {
                        objUsu.ApeMat = LeeFila[3].ToString();
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_Email")))
                    {
                        objUsu.Email = LeeFila[4].ToString();
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_Contrasenia")))
                    {
                        objUsu.Contrasenia = LeeFila[5].ToString();
                    }

                    if (!LeeFila.IsDBNull(LeeFila.GetOrdinal("USU_numDepto")))
                    {
                        objUsu.Email = LeeFila[6].ToString();
                    }

                }

                CerrarCon();
                LeeFila.Close();

                return objUsu;

            }

            catch (Exception ex)
            {
                CerrarCon();
                return objUsu;
                throw ex;
            }
        }

        public void UsuariosCRUD (INFO.Usuarios ObjUsuario,ref int sSuccess, ref string MsgErr)
        {
            try
            {
                SqlCommand cmdABC = new SqlCommand("sp_FEAI_Usuarios_CRUD", Con);
                cmdABC.CommandType = CommandType.StoredProcedure;

                AbrirCon();

                if (ObjUsuario.ID > 0)
                {
                    cmdABC.Parameters.AddWithValue("@ID", ObjUsuario.ID); //Si se omite llega como null, y se crea un registro nuevo.
                }
                cmdABC.Parameters.AddWithValue("@Nombres", ObjUsuario.Nombres);
                cmdABC.Parameters.AddWithValue("@ApPat", ObjUsuario.ApePat);
                cmdABC.Parameters.AddWithValue("@ApMat", ObjUsuario.ApeMat);
                cmdABC.Parameters.AddWithValue("@Email", ObjUsuario.Email);
                cmdABC.Parameters.AddWithValue("@Contrasenia", ObjUsuario.Contrasenia);
                cmdABC.Parameters.AddWithValue("@NumDepto", ObjUsuario.NumDepto);

                SqlParameter pSuccess = new SqlParameter("@Sucess", SqlDbType.Int);
                pSuccess.Direction = ParameterDirection.Output;
                cmdABC.Parameters.Add(pSuccess);

                SqlParameter pMsgErr = new SqlParameter("@MsgErr", SqlDbType.VarChar,200);
                pMsgErr.Direction = ParameterDirection.Output;
                cmdABC.Parameters.Add(pMsgErr);

                //cmdABC.ExecuteNonQuery();
                cmdABC.ExecuteReader();

                sSuccess = Convert.ToInt32(cmdABC.Parameters["@Sucess"].Value);
                MsgErr = cmdABC.Parameters["@MsgErr"].Value.ToString();

                CerrarCon();
            }
            catch (Exception ex )
            {
                CerrarCon();
            }
        }

        public void CreaInvitacion(INFO.Invitaciones ObjInvitacion, ref int sSuccess, ref string MsgErr)
        {
            try
            {
                SqlCommand cmdABC = new SqlCommand("sp_FEAI_Invitacion_Crear", Con);
                cmdABC.CommandType = CommandType.StoredProcedure;

                AbrirCon();

                if (ObjInvitacion.ID > 0)
                {
                    cmdABC.Parameters.AddWithValue("@ID", ObjInvitacion.ID); //Si se omite llega como null, y se crea un registro nuevo.
                }
                cmdABC.Parameters.AddWithValue("@INV_Nombre", ObjInvitacion.Nombre);
                cmdABC.Parameters.AddWithValue("@USU_Id", ObjInvitacion.USU_Id);
                cmdABC.Parameters.AddWithValue("@FechaHoraEntrada", ObjInvitacion.FechaHoraEntrada);
                cmdABC.Parameters.AddWithValue("@FechaHoraCaducidad", ObjInvitacion.FechaHoraCaducidad);

                SqlParameter pSuccess = new SqlParameter("@Sucess", SqlDbType.Int);
                pSuccess.Direction = ParameterDirection.Output;
                cmdABC.Parameters.Add(pSuccess);

                SqlParameter pMsgErr = new SqlParameter("@MsgErr", SqlDbType.VarChar, 200);
                pMsgErr.Direction = ParameterDirection.Output;
                cmdABC.Parameters.Add(pMsgErr);

                //cmdABC.ExecuteNonQuery();
                cmdABC.ExecuteReader();

                sSuccess = Convert.ToInt32(cmdABC.Parameters["@Sucess"].Value);
                MsgErr = cmdABC.Parameters["@MsgErr"].Value.ToString();

                CerrarCon();
            }
            catch (Exception ex)
            {
                CerrarCon();
            }
        }


    }


}
