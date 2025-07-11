using System.IO.Ports;
using UnityEngine;

public class SerialReader : MonoBehaviour
{
    SerialPort serialPort;

    void Start()
    {
        try
        {
            serialPort = new SerialPort("COM4", 9600); // Use COM4 for your port
            serialPort.Open();
            serialPort.ReadTimeout = 100; // Optional: Prevents infinite blocking
            Debug.Log("Serial Port Opened");
        }
        catch (System.Exception e)
        {
            Debug.LogError("Failed to open serial port: " + e.Message);
        }
    }

    void Update()
    {
        if (serialPort != null && serialPort.IsOpen) // Prevents NullReferenceException
        {
            try
            {
                string data = serialPort.ReadLine();
                Debug.Log("Received: " + data);
            }
            catch (System.TimeoutException)
            {
                // Avoid errors when no data is available
            }
        }
        else
        {
            Debug.LogWarning("Serial port not open or initialized.");
        }
    }

    void OnApplicationQuit()
    {
        if (serialPort != null && serialPort.IsOpen)
        {
            serialPort.Close();
            Debug.Log("Serial Port Closed");
        }
    }
}