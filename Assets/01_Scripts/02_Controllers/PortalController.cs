using UnityEngine;
using UnityEngine.Events;

public class PortalController : MonoBehaviour
{
    [SerializeField] private MeshRenderer meshRenderer;
    [SerializeField] private Material activeMaterial;
    [SerializeField] private Material inactiveMaterial;

    [SerializeField] private int _portalIndex;

    private UnityEvent<PortalController> _portalCrossedEvent = new UnityEvent<PortalController> ();
    public UnityEvent<PortalController> PortalCrossedEvent => _portalCrossedEvent;

    public int PortalIndex => _portalIndex;

    public void SetActiveState(bool isActive)
    {
        if (meshRenderer != null)
        {
            meshRenderer.material = isActive ? activeMaterial : inactiveMaterial;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            _portalCrossedEvent.Invoke(this);
        }
    }
}