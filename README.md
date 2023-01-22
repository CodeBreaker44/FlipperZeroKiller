# FlipperZeroKiller

### Embedded Systems Final Project 2022/2023
<img align="right" src="https://github.com/CodeBreaker44/FlipperZeroKiller/blob/main/qFlipper_macOS_256px_ugly_1_copy.png" width="200">
By Zaid Taha, Omar Hamadeh, Mohammad Elayyan



## Introduction
Typical “smart” doors these days depend on Magnetic Stripe Cards, RFID Card, or NFC tags. Unfortunately, all of these options suffer from major design flaw, they all “willingly” transmit data (The secret key/pin to open the door in this case) in plain-text. Adversaries or Threat Actors can easily clone/copy by these cards (by simply reading them!)  to unlock doors and gain unauthorized access. This type of attack is referred to as the “Replay Attack”. This project offers a fundamental solution to the problem by replacing these cards with a “smart key” containing an embedded micro-controller inside. The project will utilize proof of concept cryptographic digital signature algorithms. An authentication technique inspired by the Kerberos protocol, a widely adopted standard for authenticating Windows Computers in Corporation/Enterprise Networks, Kerberos was designed to defeat Man-in-the-middle/Replay/Cloning Attacks.


## Design
<br>
<img align="middle" src="https://github.com/CodeBreaker44/FlipperZeroKiller/blob/main/Diagrams/Screenshot_2023-01-19_141517.png">

## Web Portal
<br>
<img align="middle" src="https://github.com/CodeBreaker44/FlipperZeroKiller/blob/main/Diagrams/Screenshot 2023-01-22 190417.png">
<br>

- To deploy the web server (docker container) 
```console
foo@bar:~$ cd web/
foo@bar:~$ sudo bash build-docker.sh    # use sudo if not in docker group
```











