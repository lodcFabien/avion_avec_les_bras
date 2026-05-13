using UnityEngine;
using UnityEngine.Events;

public class PortalController : MonoBehaviour
{
    [SerializeField] private MeshRenderer _meshRenderer;
    [SerializeField] private Material _activeMaterial;
    [SerializeField] private Material _inactiveMaterial;
    [SerializeField] private ParticleSystem _particles;
    [SerializeField] private AudioSource _audioSource;

    [SerializeField] private int _portalIndex;

    private UnityEvent<PortalController> _portalCrossedEvent = new UnityEvent<PortalController> ();
    public UnityEvent<PortalController> PortalCrossedEvent => _portalCrossedEvent;

    public int PortalIndex => _portalIndex;

    public void SetActiveState(bool isActive)
    {
        if (_meshRenderer != null)
        {
            _meshRenderer.material = isActive ? _activeMaterial : _inactiveMaterial;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            _portalCrossedEvent.Invoke(this);
            _particles.Play();
            _audioSource.Play();
        }
    }
}