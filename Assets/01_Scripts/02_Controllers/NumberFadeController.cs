using TMPro;
using UnityEngine;

public class NumberFadeController : MonoBehaviour
{
    public float StartHeight { get; set; }
    public float MaxHeightDelta { get; set; }

    TMP_Text text;
    Color color;

    // Use this for initialization
    void Start()
    {
        text = GetComponent<TMP_Text>();
        color = text.color;
    }

    // Update is called once per frame
    void Update()
    {
        float h = transform.position.y;
        color.a = Mathf.Lerp(0, 1, 1 - Mathf.Abs(h - StartHeight) / MaxHeightDelta);
        text.color = color;
    }
}
