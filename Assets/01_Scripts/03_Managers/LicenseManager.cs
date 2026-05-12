using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;

public class LicenseManager : MonoBehaviour
{
    [SerializeField] private GameObject _uiPanel;
    [SerializeField] private TMP_InputField _inputField;
    [SerializeField] private TextMeshProUGUI _errorText;
    [SerializeField] private TMP_InputField _macAddressDisplay;

    private void Start()
    {
        PlayerPrefs.DeleteAll(); //delete key
        string savedKey = PlayerPrefs.GetString("GameLicenseKey", "");

        if (LicenseValidator.IsLicenseValid(savedKey))
        {
            LoadGame();
        }
        else
        {
            _uiPanel.SetActive(true);
            _errorText.text = "";
            if (_macAddressDisplay != null)
            {
                _macAddressDisplay.text = LicenseValidator.GetMacAddress();
            }
        }
    }

    public void CheckAndSaveLicense()
    {
        string newKey = _inputField.text;

        if (LicenseValidator.IsLicenseValid(newKey))
        {
            PlayerPrefs.SetString("GameLicenseKey", newKey);
            PlayerPrefs.Save();
            LoadGame();
        }
        else
        {
            _errorText.text = "Invalid Key";
        }
    }

    private void LoadGame()
    {
        SceneManager.LoadScene("Menu");
    }
}