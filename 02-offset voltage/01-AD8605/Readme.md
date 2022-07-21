# 01-AD8605 offset voltage

In order to measure the offset voltage, we can simply add this command:

`.meas TRAN Voffset AVG (V(inp)-V(out))`

![01-AD8605 offset voltage](https://user-images.githubusercontent.com/5110232/180284122-a3bb7a28-01cc-4cde-b6c5-13eb09beee18.png)

The amount of offset voltage from the datasheet of AD8605 is as follows:

![The offset from the datasheet](https://user-images.githubusercontent.com/5110232/180289330-f864e050-efb7-48f2-8640-c628d98ae1ae.png)

## Reference

https://www.analog.com/media/en/technical-documentation/data-sheets/ad8605_8606_8608.pdf
