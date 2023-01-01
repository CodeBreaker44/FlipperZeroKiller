﻿# FlipperZeroKiller

### Embedded Systems Final Project 2022/2023
By Zaid Taha, Omar Hamadeh, Mohammad Elayyan





Typical “smart” doors these days depend on Magnetic Stripe Cards, RFID Card, or NFC tags. Unfortunately, all of these options suffer from major design flaw, they all “willingly” transmit data (The secret key/pin to open the door in this case) in plain-text. Adversaries or Threat Actors can easily clone/copy by these cards (by simply reading them!)  to unlock doors and gain unauthorized access. This type of attack is referred to as the “Replay Attack”. This project offers a fundamental solution to the problem by replacing these cards with a “smart key” containing an embedded micro-controller inside. The project will utilize authentication technique inspired by the Kerberos protocol, a widely adopted standard for authenticating Windows Computers in Corporation/Enterprise Networks, Kerberos was designed to defeat Man-in-the-middle/Replay/Cloning Attacks.




