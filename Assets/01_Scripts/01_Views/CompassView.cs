using UnityEngine;
using UnityEngine.UI;

public class CompassView : MonoBehaviour
{
    [SerializeField] private Image _compass;

    public void UpdateCompass(float offset)
    {
        _compass.materialForRendering.SetFloat("_Offset", offset);

    }
}
