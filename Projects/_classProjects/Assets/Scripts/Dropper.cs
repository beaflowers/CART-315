using UnityEngine;
using System.Collections;
public class Dropper : MonoBehaviour
{
    public GameObject circle;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        StartCoroutine(Drop());
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    private IEnumerator Drop()
    {

        float chance = Random.Range(0, 100);
        if (chance < 75)
        {
            //drop something good
        }
        else
        {
            //drop something bad
        }
        //do something
        Debug.Log("Drop");
        //randomizes x+y axis dropper point
        float rX = Random.Range(-5f, 5f);
        float rY = Random.Range(-5f, 5f);
        //creates new circle
        Vector3 loc = new Vector3(rX, rY, 0);
        Instantiate(circle, loc, transform.rotation);
        
        //wait ; could escalate wait time
        float next = Random.Range(0.25f, 1.5f);
        yield return new WaitForSeconds(next);
        //go again
        StartCoroutine(Drop());

    }
}
