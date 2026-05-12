using UnityEngine;

[RequireComponent(typeof(RectTransform), typeof(BoxCollider2D))]
public class ResponsiveCollider : MonoBehaviour
{
    private RectTransform _rectTransform;
    private BoxCollider2D _boxCollider;

    private void Awake()
    {
        _rectTransform = GetComponent<RectTransform>();
        _boxCollider = GetComponent<BoxCollider2D>();
    }

    private void OnEnable()
    {
        UpdateColliderSize();
    }

    private void OnRectTransformDimensionsChange()
    {
        if (_rectTransform != null && _boxCollider != null)
        {
            UpdateColliderSize();
        }
    }

    private void UpdateColliderSize()
    {
        _boxCollider.size = _rectTransform.rect.size;
        _boxCollider.offset = _rectTransform.rect.center;
    }
}