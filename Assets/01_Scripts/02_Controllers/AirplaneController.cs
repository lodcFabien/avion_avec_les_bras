using UnityEngine;

public class AirplaneController : MonoBehaviour
{
    [SerializeField] private float yawSpeed = 1;
    [SerializeField] private float _rotationInterpSpeed = 10;
    [SerializeField] private float _baseSpeed = 20;

    [Header("Camera Settings")]
    [SerializeField] private float _cameraZDistance = -29f;
    [SerializeField] private float _cameraYOffset = 2f;

    [Header("Rotation Limits")]
    [SerializeField] private float _maxRoll = 30f;
    [SerializeField] private float _maxPitch = 30f;

    private float _forwardSpeed;
    private float yaw = 0;
    private bool _canMove = true;

    public bool CanMove
    {
        get => _canMove;
        set => _canMove = value;
    }

    public float ForwardSpeed
    {
        get => _forwardSpeed;
        set => _forwardSpeed = value;
    }

    public float CameraZDistance => _cameraZDistance;
    public float CameraYOffset => _cameraYOffset;

    private void Start()
    {
        _forwardSpeed = _baseSpeed;
    }

    void Update()
    {
        HandleSpeedInput();

        float targetRoll = Mathf.Clamp(InputManager.Instance.ArmsAngle, -_maxRoll, _maxRoll);
        float targetPitch = Mathf.Clamp(InputManager.Instance.TargetPitchAngle, -_maxPitch, _maxPitch);

        if (_canMove)
        {
            float turnPower = Mathf.Sin(targetRoll * Mathf.Deg2Rad);
            yaw += turnPower * 60f * yawSpeed * Time.deltaTime;
        }

        Quaternion targetRotation = Quaternion.Euler(-targetPitch, yaw, -targetRoll);
        transform.rotation = Quaternion.Lerp(transform.rotation, targetRotation, Time.deltaTime * _rotationInterpSpeed);

        if (_canMove)
        {
            transform.position += transform.forward * _forwardSpeed * Time.deltaTime;
        }
    }

    private void HandleSpeedInput()
    {
        if (Input.GetKeyDown(KeyCode.I)) _forwardSpeed = _baseSpeed;
        if (Input.GetKeyDown(KeyCode.O)) _forwardSpeed = _baseSpeed * 1.3f;
        if (Input.GetKeyDown(KeyCode.P)) _forwardSpeed = _baseSpeed * 1.6f;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Obstacle"))
        {
            _canMove = false;
            gameObject.SetActive(false);
        }
    }
}