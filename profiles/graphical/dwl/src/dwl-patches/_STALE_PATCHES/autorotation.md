### Description
Adds keybindings for screen rotation and auto rotation from an accelerometer.

### Setup
Find an accelerometer device in sysfs (`cat /sys/bus/iio/devices/iio*/name`,
or using a script: [monitor-iio.sh](https://github.com/Unprex/dotfiles/blob/main/scripts/monitor-iio.sh)) \
Find the raw output file of the accelerometer
(e.g. `cat /sys/bus/iio/devices/iio:device0/in_accel_x_raw` should output an integer). \
Add the raw output file names to the dwl configuration **accel_\***.

Add a udev rule to uniquely identify the device, for example:
```
sudo echo 'SUBSYSTEM=="iio", KERNEL=="iio*", ATTR{name}=="accel_3d", GROUP="input", SYMLINK+="input/accel"' >> /etc/udev/rules.d/99-accel.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
```
(the device is probably already in /dev/ e.g. `/dev/iio:device0` but on my computer the number changes after a reboot)

A symlink to the device should now be available in `/dev/input/` and accessible to input group members. \
Add the device path to the dwl configuration **accel_path**.

### Config
* `rotation_enabled`: If the auto rotation is enabled on startup.
* `rotation_delay`: How often to check the accelerometer values in milliseconds. 
* `rotation_flat`: Threshold on the normalized Z axis to consider the device flat and stop the auto rotation.
* `rotation_thresh`: Rotation threshold after which the screen flips (values less than 0.5 will cause a back and forth).

+ `accel_path`: The path to the accelerometer device file (e.g. "/dev/input/accel").
+ `accel_x`: The name of the sysfs file for the accelerometer x axis.
+ `accel_y`: The name of the sysfs file for the accelerometer y axis.
+ `accel_z`: The name of the sysfs file for the accelerometer z axis.

Default keybindings:
* `<Modkey>` + `<Shift>` + `<Arrows>`: Change the screen rotation manually (doesn't disable the auto rotation).
* `<Modkey>` + `<Shift>` + `<R>`: Enable/disable the auto rotation.

### Download
- [2022-10-25](https://github.com/djpohly/dwl/compare/main...Unprex:rotation.patch)

### Authors
- [Unprex](https://github.com/Unprex)