# 01-AD8605 offset voltage

In order to measure the offset voltage, we can simply add this command:

`.meas TRAN Voffset AVG (V(inp)-V(out))`

![01-AD8605 offset voltage bias current](https://user-images.githubusercontent.com/5110232/180419342-c5dbee52-1a65-4562-a3d5-a270fd269e1b.PNG)

The amount of offset voltage from the datasheet of AD8605 is as follows:

![The offset voltage from the datasheet](https://user-images.githubusercontent.com/5110232/180289330-f864e050-efb7-48f2-8640-c628d98ae1ae.png)

The bias current, however, seems less than what we expect.

![The bias current from the datasheet](https://user-images.githubusercontent.com/5110232/180419692-10e1df24-7411-42e4-96d0-96a9b92fca9c.png)

## Reference

https://www.analog.com/media/en/technical-documentation/data-sheets/ad8605_8606_8608.pdf
