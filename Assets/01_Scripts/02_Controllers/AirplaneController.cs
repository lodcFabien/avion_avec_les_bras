using UnityEngine;
using UnityEngine.Events;

public class AirplaneController : MonoBehaviour
{
    [SerializeField] private InputController inputController;

    [SerializeField] private float yawSpeed = 1;
    [SerializeField] private float rotationSpeed = 10;
    [SerializeField] private UnityEvent onCrash;
    [SerializeField] private float _forwardSpeed = 20;
    
    private float yaw = 0;
    private bool _canMove = false;

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
        float targetRoll = inputController.TargetRollAngle;
        float targetPitch = inputController.TargetPitchAngle;

        if (_canMove)
        {
            yaw += targetRoll * yawSpeed * Time.deltaTime;
        }

        Quaternion targetRotation = Quaternion.Euler(-targetPitch, yaw, -targetRoll);

        transform.rotation = Quaternion.Lerp(transform.rotation, targetRotation, Time.deltaTime * rotationSpeed);

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
            onCrash?.Invoke();
            gameObject.SetActive(false);
        }
    }
}