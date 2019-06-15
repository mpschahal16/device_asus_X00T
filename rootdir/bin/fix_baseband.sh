#!/system/bin/sh

# Set GSM baseband
setprop gsm.version.baseband `strings /vendor/firmware_mnt/image/modem.b17 | grep "^MPSS.AT" | head -1`
