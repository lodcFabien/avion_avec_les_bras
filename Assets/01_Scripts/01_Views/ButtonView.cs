using UnityEngine;
using UnityEngine.UI;

public class ButtonView : MonoBehaviour
{
    [SerializeField] private Image _image;

    public void UpdateFill(float value)
    {
        _image.materialForRendering.SetFloat("_Value", value);

    }
}
