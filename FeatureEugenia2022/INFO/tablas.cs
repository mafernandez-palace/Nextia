using System;

namespace INFO
{
    public class Usuarios
    {
        public int ID { get; set; } 
        public string Nombres { get; set; }
        public string ApePat { get; set; }
        public string ApeMat { get; set; }
        public string Email { get; set; }
        public string Contrasenia { get; set; }
        public int NumDepto { get; set; }

    }
    public class Invitaciones
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public int USU_Id { get; set; }
        public DateTime FechaHoraEntrada { get; set; }
        public DateTime FechaHoraCaducidad { get; set; }

    }

    public class Reporte_Invitaciones
    { 
        public int INV_ID { get; set; }
        public string INV_Nombre { get; set; }
        public string Nombres { get; set; }
        public string ApePat { get; set; }
        public string ApeMat { get; set; }
        public string Email { get; set; }
        public int NumDepto { get; set; }
        public DateTime FechaHoraEntrada { get; set; }
        public DateTime FechaHoraCaducidad { get; set; }


    }
}
