using System.Net.Http.Json;
using System.Net.Http.Headers;

namespace SentraqCommon.Services;

/// <summary>
/// Proof of concept for sending SMS alerts via gatewayapi.com
/// </summary>
public class SmsService
{
    public async void SendSms()
    {
        using HttpClient client = new HttpClient();

        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(
            "Token",
            "<todo>"
        );

        var messages = new {
            sender = "WWP",
            message = "Ein Alarm ist aufgetreten!",
            recipients = new[] { new { msisdn = 49_123_45678 }},
        };

        using var resp = await client.PostAsync(
            "https://gatewayapi.com/rest/mtsms",
            JsonContent.Create(messages)
        );

// On 2xx, print the SMS IDs received back from the API
// otherwise print the response content to see the error:
        if (resp.IsSuccessStatusCode && resp.Content != null) {
            Console.WriteLine("success!");
            var content = await resp.Content.ReadFromJsonAsync<Dictionary<string, dynamic>>();
            foreach (var smsId in content["ids"].EnumerateArray()) {
                Console.WriteLine("allocated SMS id: {0:G}", smsId);
            }
        } else if (resp.Content != null) {
            Console.WriteLine("failed :(\nresponse content:");
            var content = await resp.Content.ReadAsStringAsync();
            Console.WriteLine(content);
        }
    }
}