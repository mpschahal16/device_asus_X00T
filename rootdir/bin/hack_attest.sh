#! /system/bin/sh

statuselinux=`getprop ro.boot.veritymode`
statuselinux_temp=0

# Attest method hack google pay
if [ -w /data/data/com.google.android.gms/databases/dg.db ]; then

    if [ "$statuselinux" == "enforcing" ]; then 
       statuselinux_temp=1
       setenforce 0 
    fi

    rm -rf /data/data/com.google.android.gms/app_dg_cache/*
    sqlite3 -batch /data/data/com.google.android.gms/databases/android_pay "update Wallets set fails_attestation='0'"
    sqlite3 -batch /data/data/com.google.android.gms/databases/dg.db "update main set c=0 where a like '%attest%'"
    chmod 440 /data/data/com.google.android.gms/databases/dg.db

    if [ $statuselinux_temp == 1 ]; then
       setenforce 1
    fi
fi