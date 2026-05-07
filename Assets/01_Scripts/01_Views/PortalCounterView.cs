using UnityEngine;
using TMPro;

public class PortalCounterView : MonoBehaviour
{
    [SerializeField] private TextMeshProUGUI _counterText;
    private int _totalPortals;

    public void Initialize(int totalPortals)
    {
        _totalPortals = totalPortals;
        UpdateCounter(0);
    }

    public void UpdateCounter(int currentPortal)
    {
        _counterText.text = "Portail " +  currentPortal + " / " + _totalPortals;
    }
}