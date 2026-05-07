using UnityEngine;

public class HandController : MonoBehaviour
{
    [SerializeField] private RectTransform _rectTransform;
    public RectTransform RectTransform => _rectTransform;

    private void OnTriggerEnter2D(Collider2D collision)
    {
        IUiCollidable collidable = collision.gameObject.GetComponent<IUiCollidable>();
        if (collidable != null)
        {
            collidable.OnStartCollision(this);
        }
    }

    private void OnTriggerExit2D(Collider2D collision)
    {
        IUiCollidable collidable = collision.gameObject.GetComponent<IUiCollidable>();
        if (collidable != null)
        {
            collidable.OnStopCollision(this);
        }
    }
}
