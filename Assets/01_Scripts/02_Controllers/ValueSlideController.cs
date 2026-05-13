using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ValueSlideController : MonoBehaviour
{
    [SerializeField] private int _numberOfText;

    [SerializeField] private TMP_Text _textPrefab;

    [SerializeField] private TMP_Text _textDisplay;



    private int _totalNumberOfText;
    private float _textHeight;
    private TMP_Text[] _textArray;
    private Vector3 _originalPos;

    // Use this for initialization
    void Start()
    {
        _originalPos = transform.localPosition;
        _textHeight = _textPrefab.GetComponent<RectTransform>().sizeDelta.y;

        GenerateText();

        RectOffset offset = new RectOffset(0, 0, (int)(-_textHeight * (_numberOfText - 0.5f)), 0);
        GetComponent<VerticalLayoutGroup>().padding = offset;
    }

    /// <summary>
    /// Generate the text listing all the values
    /// </summary>
    public void GenerateText()
    {
        _totalNumberOfText = _numberOfText * 2 + 1;
        _textArray = new TMP_Text[_totalNumberOfText];

        //Max distance the numbers can be from the center without being totally faded out
        float maxHeightDelta = _numberOfText * _textHeight;

        for (int i = 0; i < _totalNumberOfText; i++)
        {
            _textArray[i] = Instantiate(_textPrefab, transform) as TMP_Text;

            //Set the fadding behaviour of the numbers
            NumberFadeController f = _textArray[i].GetComponent<NumberFadeController>();
            f.StartHeight = transform.position.y;
            f.MaxHeightDelta = maxHeightDelta;
        }

    }

    public void SetValue(float value)
    {
        float floor = Mathf.Floor(value);
        float floating = value - floor;
        int currentValue = (int)floor - _numberOfText;

        for (int i = _totalNumberOfText - 1; i >= 0; i--)
        {
            _textArray[i].text = currentValue.ToString();
            currentValue++;
        }
        transform.localPosition = _originalPos + Vector3.up * (Mathf.Lerp(0, _textHeight, 1 - floating) - _textHeight);

        _textDisplay.text = Mathf.Round(value).ToString();
    }
}
