using UnityEngine;
using System.Collections;

public class Appear : MonoBehaviour
{
    public GameObject circle; //prefab
    private GameObject current; //active circle
    private int counter = 0; //to make sure spawning stops at some point

    void Start()
    {
        StartCoroutine(Appears());
    }

    private IEnumerator Appears()
    {
        while (counter < 80)
        {
            Debug.Log("Appear");

            // Randomizes x + y axis dropper point
            float rX = Random.Range(-9f, -6f); //x left edge
            float rX2 = Random.Range(6f, 9f); //x right edge
            float rY = Random.Range(-5f, 5f);
            
            bool randomEdge = (Random.value > 0.5f); //determines x spawning on right or left side
            
            // Creates new sprite; trying to only spawn on edges of the screen, sort of works ok?
            Vector3 pos = randomEdge ? new Vector3(rX, rY, 0f) : new Vector3(rX2, rY, 0f);
            current = Instantiate(circle, pos, transform.rotation);
            //counter increment
            counter++;
            Debug.Log(counter);
            
            // Wait until the circle is destroyed (credit to chatGPT)
            yield return new WaitUntil(() => current == null);
        }
    }

}