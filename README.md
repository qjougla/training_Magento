# MAGENTO TRAINING
## Install

```CLI
chmod u+x ./scripts/check-requirements.sh && ./scripts/check-requirements.sh
```
result : `Perfect: all requirements are satisfied. You can continue the install process :)
`<br><br>
`make`  <= if error go in .env file and change the path in `APP_LOCAL_ROOT=../magento/`<br>
`make startd`<br>
`make ps`<br>
`make magento-install` <= to install Magento (it's take's a long time)<br>
the important message is `[SUCCESS]: Magento installation complete`<br>
Disanle Magento_TwoFactorAuth module `./run exec php bin/magento module:disable Magento_TwoFactorAuth`<br>
sample data : 
- `make magento-install-sampledata`
- `make bash`
- `php bin/magento sampledata:deploy`
- `php bin/magento setup:upgrade`