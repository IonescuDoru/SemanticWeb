using System.Text.Json.Serialization;

namespace SemanticWeb.Models;

public class RezultatItem
{
    public int Ind { get; set; }

    public string? Title { get; set; }

    public string? Author { get; set; }

    public string? Publisher { get; set; }

    public string? Year { get; set; }

    public string? Photo { get; set; }

    public string? Isbn { get; set; }

    //public string? Price { get; set; }    

    public double Scor { get; set; }  
}

