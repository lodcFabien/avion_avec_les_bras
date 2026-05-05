using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public void LoadLevel(int levelIndex)
    {
        GameManager.SelectedLevelIndex = levelIndex;
        SceneManager.LoadScene("GameScene");
    }
}