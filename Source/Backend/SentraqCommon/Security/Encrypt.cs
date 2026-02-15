using System.Security.Cryptography;

namespace SentraqCommon.Security;

public static class Encrypt
{
    // Encrypt a string into an encrypted string by using a password and the Rijndael algorithm.
    public static string Text(string clearText, string pwd)
    {
        var clearBytes =
            System.Text.Encoding.Unicode.GetBytes(clearText);

        var pdb = new PasswordDeriveBytes(pwd,
            new byte[] {
                0x49, 0x23, 0x62, 0x6e, 0x12, 0x4d, 0x65, 0x66, 0x91, 0x34, 0x64, 0x10, 0x77
            });

        var encryptedData = EncryptText(clearBytes,
            pdb.GetBytes(32), pdb.GetBytes(16));

        return Convert.ToBase64String(encryptedData);
    }

    // Encrypt a byte array into a byte array using a key and an IV 
    private static byte[] EncryptText(byte[] clearData, byte[] Key, byte[] IV)
    {
        MemoryStream ms = new MemoryStream();
        var alg = Rijndael.Create();

        alg.Key = Key;
        alg.IV = IV;

        var cs = new CryptoStream(ms,
            alg.CreateEncryptor(), CryptoStreamMode.Write);

        cs.Write(clearData, 0, clearData.Length);
        cs.Close();

        var encryptedData = ms.ToArray();

        return encryptedData;
    }
}