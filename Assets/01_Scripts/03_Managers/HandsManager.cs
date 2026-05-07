using UnityEngine;
using UnityEngine.UI;

public class HandsManager : MonoBehaviour
{
    [SerializeField] private HandController _leftHand;
    [SerializeField] private HandController _rightHand;

    private void Update()
    {
        _leftHand.RectTransform.position = new Vector3(InputManager.Instance.LeftHandCanvasPos.x, InputManager.Instance.LeftHandCanvasPos.y,0);
        _rightHand.RectTransform.position = new Vector3(InputManager.Instance.RightHandCanvasPos.x, InputManager.Instance.RightHandCanvasPos.y, 0);
    }
}
