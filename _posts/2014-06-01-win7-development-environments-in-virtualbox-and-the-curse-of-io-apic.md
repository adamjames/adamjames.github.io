---
layout: post
title: Windows 7 development in VirtualBox and the curse of IO-APIC / Guest Additions
tags: 
- windows
- software-development
- virtualbox 
- io-apic
---

When creating a Windows VM for development, it might seem obvious to install a 64-bit version of Windows.<!-- more --> However, this results in Virtualbox enabling I/O APIC (Input/Output Advanced Programmable Interrupt Controller) emulation. This is required when using a 64-bit version of Windows or passing multiple CPU cores through to your virtual machine. Disabling it will result in Windows refusing to even load the installer. So you enable it, install Windows (looks a little slow, but hey; it's a VM, right?) and go on your merry way. 

After a while though, you begin to notice that the slowness seems unreasonable. So you look around. You might find a [ticket] [vboxticket] describing the slowness. You find somewhat-related [instructions] [migrate] for Windows XP, but they're hit and miss too. So you try to disable I/O APIC, only to find out you can't. Even editing the config file manually doesn't do it. So you try setting it read only and making the change, only to see Windows crash when the kernel can't find CPU features it needs because they've __vanished from underneath it__. You look around some more, finding out that fixing the problem means swapping out the Hardware Abstraction Layer that sits between the Windows kernel and the hardware, maybe even about __sysprep /generalize__, which allows you to move a Windows system image between machines of any architecture and have them re-initialise themselves on the first boot (if you're interested, this is a feature intended for systems administrators and OEM's who want to deploy a standard OS image across a heterogeneous set of hardware.) You try it out, but the machine becomes completely unresponsive even after leaving it overnight to churn away; and crashes. Your machine is destroyed.

The solution to this is to install a __32-bit version of Windows__ in your VM, which does not require I/O APIC emulation. Enable everything you like, __except__ I/O APIC support - and __only pass in a single CPU core__ for use by your VM. You'll get a usable machine (at least twice as fast) and it's a damn sight better than having something that doesn't work at all. 

If you find that Windows fails to boot after installing the Guest Additions __without__ Direct3D support, hard power-off and make sure that 3D acceleration is turned __off__ in the VM's options (leaving 2D checked) before rebooting. The machine should come back up without any issues aside from a minor complaint about not being shut down properly. You should now find that all Guest Additions features (Shared Folders, USB support, standard 2D acceleration...) work fine. Aero transparency won't work, but Windows is much more responsive without it turned on anyway. 

[vboxticket]: https://www.virtualbox.org/ticket/4392
[migrate]: https://www.virtualbox.org/wiki/Migrate_Windows