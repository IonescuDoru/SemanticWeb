using System.Text.Json.Serialization;

namespace SemanticWeb.Models;

public class RezultatItem
{
    [JsonPropertyName("bookId")]
    public int BookId { get; set; }

    [JsonPropertyName("scor")]
    public double Scor { get; set; }

    [JsonPropertyName("motiv")]
    public string? Motiv { get; set; }
}
