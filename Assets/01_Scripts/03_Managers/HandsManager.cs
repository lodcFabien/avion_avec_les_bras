using UnityEngine;

public class HandsManager : MonoBehaviour
{
    [SerializeField] private HandController _leftHand;
    [SerializeField] private HandController _rightHand;
    [SerializeField] private float _smoothSpeed = 15;

    private void Update()
    {
        Vector3 targetLeft = new Vector3(InputManager.Instance.LeftHandCanvasPos.x, InputManager.Instance.LeftHandCanvasPos.y, 0);
        Vector3 targetRight = new Vector3(InputManager.Instance.RightHandCanvasPos.x, InputManager.Instance.RightHandCanvasPos.y, 0);

        _leftHand.RectTransform.position = Vector3.Lerp(_leftHand.RectTransform.position, targetLeft, Time.deltaTime * _smoothSpeed);
        _rightHand.RectTransform.position = Vector3.Lerp(_rightHand.RectTransform.position, targetRight, Time.deltaTime * _smoothSpeed);
    }
}