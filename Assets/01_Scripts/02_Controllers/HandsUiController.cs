using UnityEngine;
using UnityEngine.UI;

public class HandsUiController : MonoBehaviour
{
    [SerializeField] private Image _leftHand;
    [SerializeField] private Image _rightHand;

    private void Update()
    {
        _leftHand.rectTransform.position = new Vector3(InputManager.Instance.LeftHandCanvasPos.x, InputManager.Instance.LeftHandCanvasPos.y,0);
        _rightHand.rectTransform.position = new Vector3(InputManager.Instance.RightHandCanvasPos.x, InputManager.Instance.RightHandCanvasPos.y, 0);
    }
}
