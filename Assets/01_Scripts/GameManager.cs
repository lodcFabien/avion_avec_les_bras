using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    private static int _selectedLevelIndex = 0;

    public static int SelectedLevelIndex
    {
        get => _selectedLevelIndex;
        set => _selectedLevelIndex = value;
    }

    [SerializeField] private List<Transform> _levelManagers;
    [SerializeField] private TextMeshProUGUI _countdownText;
    [SerializeField] private TextMeshProUGUI _endText;
    [SerializeField] private CameraController _cameraController;
    [SerializeField] private GameObject _gameFinished;
    [SerializeField] private PortalCounterUI _portalCounterUI;

    private AirplaneController _activeAirplane;
    private List<Portal> _portals = new List<Portal>();
    private int _currentPortalIndex = 0;

    void Start()
    {
        for (int i = 0; i < _levelManagers.Count; i++)
        {
            _levelManagers[i].gameObject.SetActive(i == SelectedLevelIndex);
        }

        Transform activeManager = _levelManagers[SelectedLevelIndex];
        LevelData levelData = activeManager.GetComponent<LevelData>();

        _activeAirplane = Instantiate(levelData.airplanePrefab, levelData.spawnPoint.position, levelData.spawnPoint.rotation);

        _activeAirplane.CanMove = false;
        _cameraController.Airplane = _activeAirplane;

        _portals = new List<Portal>(activeManager.GetComponentsInChildren<Portal>());
        _portals.Sort((p1, p2) => p1.PortalIndex.CompareTo(p2.PortalIndex));
        _portals.ForEach(x => x.PortalCrossedEvent.AddListener(ActionOnPortalCrossed));

        _portalCounterUI.Initialize(_portals.Count);

        _gameFinished.SetActive(false);

        UpdatePortalsState();
        StartCoroutine(CountdownRoutine());
    }

    private void ActionOnPortalCrossed(Portal portal)
    {
        if (portal.PortalIndex == _currentPortalIndex)
        {
            _currentPortalIndex++;

            _portalCounterUI.UpdateCounter(_currentPortalIndex);

            UpdatePortalsState();

            if (_currentPortalIndex >= _portals.Count)
            {
                OnLevelComplete();
            }
        }
    }
    private IEnumerator CountdownRoutine()
    {
        _countdownText.gameObject.SetActive(true);

        _countdownText.text = "3";
        yield return new WaitForSeconds(1);

        _countdownText.text = "2";
        yield return new WaitForSeconds(1);

        _countdownText.text = "1";
        yield return new WaitForSeconds(1);

        _countdownText.text = "Go";
        _activeAirplane.CanMove = true;

        yield return new WaitForSeconds(1);
        _countdownText.gameObject.SetActive(false);
    }

    private void UpdatePortalsState()
    {
        for (int i = 0; i < _portals.Count; i++)
        {
            _portals[i].SetActiveState(i == _currentPortalIndex);
        }
    }

    private void OnLevelComplete()
    {
        _endText.text = "bravo \nvous avez gagné";
        _gameFinished.SetActive(true);
        _activeAirplane.CanMove = false;
    }

    public void OnPlayerCrash()
    {
        _endText.text = "game over";
        _gameFinished.SetActive(true);
    }

    public void RestartLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    public void GoToMenu()
    {
        SceneManager.LoadScene("Menu");
    }
}