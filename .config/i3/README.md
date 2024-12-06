## Adding to battery notification to crontab
The config bellow will run the `battery.sh` every 15 minutes.
```shell
# Edit crontab
crontab -e

# Add the below line to the end of the file
*/15 * * * * /bin/bash $HOME/.config/i3/battery.sh
```
**NOTE**: replace the `$HOME` with your absolute home path.
