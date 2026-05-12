using UnityEngine;
using TMPro;
using System;

public class KeyGeneratorView: MonoBehaviour
{
    [SerializeField] private TMP_InputField _macInput;
    [SerializeField] private TMP_InputField _monthsInput;
    [SerializeField] private TextMeshProUGUI _currentDateText;
    [SerializeField] private TextMeshProUGUI _expirationDateText;
    [SerializeField] private TMP_InputField _outputKey;

    private DateTime _currentDate;
    private DateTime _expirationDate;

    private void Start()
    {
        _monthsInput.text = "6";
        UpdateDates();
    }

    public void OnMonthsChanged()
    {
        UpdateDates();
    }

    private void UpdateDates()
    {
        _currentDate = DateTime.Now;
        if (_currentDateText != null)
        {
            _currentDateText.text = _currentDate.ToString("yyyy-MM-dd");
        }

        int months;
        if (int.TryParse(_monthsInput.text, out months))
        {
            _expirationDate = _currentDate.AddMonths(months);
            if (_expirationDateText != null)
            {
                _expirationDateText.text = _expirationDate.ToString("yyyy-MM-dd");
            }
        }
        else
        {
            if (_expirationDateText != null)
            {
                _expirationDateText.text = "Invalid";
            }
        }
    }

    public void OnClickGenerate()
    {
        string mac = _macInput.text;

        int tempMonths;
        if (string.IsNullOrEmpty(mac) || !int.TryParse(_monthsInput.text, out tempMonths))
        {
            return;
        }

        string dateStr = _expirationDate.ToString("yyyy-MM-dd");
        string generatedKey = LicenseValidator.GenerateKey(mac, dateStr);
        _outputKey.text = generatedKey;
    }

    public void OnClickCopy()
    {
        GUIUtility.systemCopyBuffer = _outputKey.text;
    }
}