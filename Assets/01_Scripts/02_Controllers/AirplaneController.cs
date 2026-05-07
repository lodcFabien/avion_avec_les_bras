using UnityEngine;
using UnityEngine.Events;

public class AirplaneController : MonoBehaviour
{

    [SerializeField] private float yawSpeed = 1;
    [SerializeField] private float _rotationInterpSpeed = 10;
    [SerializeField] private float _forwardSpeed = 20;
    
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

    void Update()
    {
        float keyboardSensitivity = InputManager.Instance.UseKeyboard ? .05f : 1f;

        float targetRoll = Mathf.Clamp(InputManager.Instance.ArmsAngle, -30, 30);
        float targetPitch = Mathf.Clamp(InputManager.Instance.TargetPitchAngle,-30,30);

        if (_canMove)
        {
            yaw += targetRoll * yawSpeed * Time.deltaTime * keyboardSensitivity;
        }

        Quaternion targetRotation = Quaternion.Euler(-targetPitch, yaw, -targetRoll);

        transform.rotation = Quaternion.Lerp(transform.rotation, targetRotation, Time.deltaTime * _rotationInterpSpeed * keyboardSensitivity);

        if (_canMove) 
        {
            transform.position += transform.forward * _forwardSpeed * Time.deltaTime;
        }
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