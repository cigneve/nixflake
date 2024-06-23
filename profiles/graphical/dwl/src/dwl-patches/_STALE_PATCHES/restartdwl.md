### Description
This patch allows you to restart dwl with a keybinding.  
**NOTE:** that all of your applications are gonna get killed on dwl restart.
  
The function creates a file at **/tmp/restart_dwl** and exits dwl.  
You have to modify your dwl launch script in order for this patch to work.  
Example dwl launch script:  
```sh
do=true
while $do ||  [ -f /tmp/restart_dwl ]; do
    do=false
    rm -rf /tmp/restart_dwl > /dev/null 2>&1
    dwl
done
```
It's a do-while that checks if **/tmp/restart_dwl** exists after the first run of dwl.  
If this file exists delete it and start dwl again.  

### Download
- [2022-10-27](https://github.com/djpohly/dwl/compare/main...krypciak:patch-restartdwl.patch)

### Authors
- [krypciak](https://github.com/krypciak)