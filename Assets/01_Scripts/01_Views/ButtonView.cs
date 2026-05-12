using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class ButtonView : MonoBehaviour
{
    [SerializeField] private Image _image;
    [SerializeField] private TextMeshProUGUI _buttonText;
    [SerializeField] private Color _textEmptyColor = Color.white;
    [SerializeField] private Color _textFilledColor = Color.black;

    private void Start()
    {
        if (_image != null && _image.material != null)
        {
            _image.material = new Material(_image.material);
        }
    }

    public void UpdateFill(float value)
    {
        if (_image != null && _image.materialForRendering != null)
        {
            _image.materialForRendering.SetFloat("_Value", value);
        }

        if (_buttonText != null)
        {
            _buttonText.color = Color.Lerp(_textEmptyColor, _textFilledColor, value);
        }
    }
}