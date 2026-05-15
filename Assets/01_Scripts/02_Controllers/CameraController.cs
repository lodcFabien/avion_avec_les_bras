using UnityEngine;

public class CameraController : MonoBehaviour
{
    [SerializeField] private float _rotationInterploationSpeed = 10;
    [SerializeField] private Transform _cameraContainer;

    private AirplaneController _airplane;

    public AirplaneController Airplane
    {
        get => _airplane;
        set
        {
            _airplane = value;
            ApplyCameraOffsets();
        }
    }

    private void LateUpdate()
    {
        if (_airplane == null) return;

        SetCameraPosition();
        SetCameraRotation();
    }

    private void SetCameraPosition()
    {
        this.transform.position = _airplane.transform.position;
    }

    private void SetCameraRotation()
    {
        if (!_airplane.CanMove) return;
        Vector3 currentRotation = this.transform.eulerAngles;
        Vector3 targetRotation = new Vector3(0, _airplane.transform.eulerAngles.y, 0);
        this.transform.rotation = Quaternion.Lerp(Quaternion.Euler(currentRotation), Quaternion.Euler(targetRotation), Time.deltaTime * _rotationInterploationSpeed);
    }

    private void ApplyCameraOffsets()
    {
        if (_airplane == null || _cameraContainer == null) return;

        // On applique Y et Z en une seule fois sur le container
        Vector3 newLocalPos = _cameraContainer.localPosition;
        newLocalPos.y = _airplane.CameraYOffset;
        newLocalPos.z = _airplane.CameraZDistance;
        _cameraContainer.localPosition = newLocalPos;
    }
}