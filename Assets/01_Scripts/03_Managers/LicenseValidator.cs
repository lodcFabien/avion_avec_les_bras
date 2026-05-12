using System;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Text;

public static class LicenseValidator
{
    private static readonly string SecretKey = "L490SGJ20DM43910QSWN290GB3RG8GLC";

    public static string GetMacAddress()
    {
        NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
        NetworkInterface bestNic = nics.FirstOrDefault(n => n.OperationalStatus == OperationalStatus.Up && n.NetworkInterfaceType != NetworkInterfaceType.Loopback);
        if (bestNic != null) return bestNic.GetPhysicalAddress().ToString();
        return "UNKNOWN_MAC";
    }

    public static bool IsLicenseValid(string encryptedKey)
    {
        if (string.IsNullOrEmpty(encryptedKey)) return false;

        try
        {
            string decrypted = Decrypt(encryptedKey);
            string[] parts = decrypted.Split('|');

            if (parts.Length != 2) return false;

            string targetMac = parts[0];
            DateTime expirationDate = DateTime.Parse(parts[1]);
            string currentMac = GetMacAddress();

            if (currentMac == targetMac && DateTime.Now <= expirationDate)
            {
                return true;
            }
            return false;
        }
        catch
        {
            return false;
        }
    }

    public static string GenerateKey(string macAddress, string expirationDateYYYYMMDD)
    {
        string rawLicense = $"{macAddress}|{expirationDateYYYYMMDD}";
        return Encrypt(rawLicense);
    }

    private static string Encrypt(string clearText)
    {
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(SecretKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                return Convert.ToBase64String(ms.ToArray());
            }
        }
    }

    private static string Decrypt(string cipherText)
    {
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(SecretKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                return Encoding.Unicode.GetString(ms.ToArray());
            }
        }
    }
}