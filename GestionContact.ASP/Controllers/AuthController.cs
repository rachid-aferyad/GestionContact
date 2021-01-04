using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace ASP.Exercises.Controllers
{
    public class AuthController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(string firstName, 
                                        string lastName, 
                                        string phone, 
                                        string email, 
                                        string password, 
                                        string birthDate, 
                                        string confirmPassword)
        {
            if(
                firstName is null || lastName is null || password is null ||
                firstName.Trim().Length == 0 || 
                lastName.Trim().Length == 0 || 
                password.Trim().Length < 8 || 
                password.Trim() != confirmPassword?.Trim() )
            {
                return View();
            }
            using(SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=GestionContact.DB;Integrated Security=True;";
                
                using(SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "CSP_AddContact";
                    command.Parameters.AddWithValue("LastName", lastName.Trim());
                    command.Parameters.AddWithValue("FirstName", firstName.Trim());
                    command.Parameters.AddWithValue("Email", email.Trim());
                    command.Parameters.AddWithValue("Phone", phone.Trim());
                    command.Parameters.AddWithValue("Password", password.Trim());
                    command.Parameters.AddWithValue("BirthDate", birthDate.Trim());
                    connection.Open();
                    int id = (int)command.ExecuteScalar();

                    return RedirectToAction("Index", "Home");
                }
            }
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string email, string password)
        {
            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=GestionContact.DB;Integrated Security=True;";
                IList<string> contacts = new List<string>();
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "SP_CheckContact";
                    command.Parameters.AddWithValue("Email", email);
                    command.Parameters.AddWithValue("Password", password);
                    connection.Open();

                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            contacts.Add($"{dr["FirstName"]} - {dr["LastName"]} - {dr["Email"]} - {dr["Phone"]} - {dr["BirthDate"]}");
                        }
                    }

                    bool isLogin = contacts.Count == 1;
                    ViewBag.IsLogin = isLogin;

                    return RedirectToAction("Index", "Home");
                }
            }
        }
    }
}
