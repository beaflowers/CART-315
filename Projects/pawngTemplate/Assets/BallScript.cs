using System;
using System.Collections;
using UnityEngine;
using Random = UnityEngine.Random;

public class BallScript : MonoBehaviour
{
    

    private Rigidbody2D rb;
    public float ballSpeed = 2;
    private int[] directions = { -1, 1 };
    private int hDir, vDir;

    public int score1, score2;
    public AudioSource blip;
        

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        //sets target variable from within the script, rather than set in unity inspector
        rb = gameObject.GetComponent<Rigidbody2D>();
        StartCoroutine(Launch());
    }

    private void OnCollisionEnter2D(Collision2D wall)
    {
        if (wall.gameObject.name == "leftWall")
        {
            //points to player 2
            score2++;
            Reset();
        }
        if (wall.gameObject.name == "rightWall")
        {
            //points to player 1
            score1++;
            Reset();
        }
        if (wall.gameObject.name == "topWall" || wall.gameObject.name == "bottomWall")
        {
            blip.pitch = 0.75f;
            blip.Play();
        }
        
        if (wall.gameObject.name == "paddleLeft" || wall.gameObject.name == "paddleRight")
        {
            blip.pitch = 1f;
            blip.Play();
        }
    }

// Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator Launch()
    {
        //choose random X direction
        hDir = directions[Random.Range(0, directions.Length)];
        //choose random Y direction
        vDir = directions[Random.Range(0, directions.Length)];
        Random.Range(0, directions.Length);
        
        
        //wait
        yield return new WaitForSeconds(1f);
        
        //apply force
        rb.AddForce(transform.right * ballSpeed * hDir);
        rb.AddForce(transform.up * ballSpeed * vDir);
        
        
    }

    void Reset()
    {
        rb.linearVelocity = Vector2.zero;
        this.transform.localPosition = new Vector3(0, 0, 0);
        
        StartCoroutine(Launch());
    }
}
