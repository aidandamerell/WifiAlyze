# WifiAlyze

## Synopsis
A script to monitor a network interface in promiscous mode and detect packets which are either malicious or administrative.
Obviously this only works on networks which broadcast traffic (Wireless and Hub networks).

## Usage
```
./wifialyze.rb wlan0
```

## Motivation
The motivation was simply to test Rubys networking functionality, but also to assist in segmentation testing.

## Example
running wifialyze on a wireless network.
```
Port => Packets
445 => 8
389 => 2
3389 => 2
139 => 1
1025 => 1

```
The script will output basic information to STDOUT and also a file containing further information about the instance.
