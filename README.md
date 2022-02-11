# write-SystemInfo
PowerShell scirpt to write to console various hardware information about a device (Windows PC/Laptop).  Information includes details like CPUs, GPUs, Interface Adapters, Monitors, Battery and more.


.EXAMPLE      write-SystemInfo.ps1

  Computer System: LENOVO      20L6S1E700 (aka= T480)

  CPU0 : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz   [4 cores / 8 threads]

  GPU2:  [ 1GB VRAM /  Drv Ver: 30.0.101.1122 ]  (1920x1080 @ 60Hz) Intel(R) UHD Graphics 620

  Monitor: DELL P2417H     [ S/N: J1#######FL ]

  Interface:  [ ( Up ) 1 Gbps / 10.###.###.### ] Ethernet

  ExtIPv4: 2##.1##.###.### [ Loc: SomeTown, Texas  (3#.#### / -9#.####) ]

  Drive: C:\ [ (OS Drive) NTFS / Fixed / Lbl: "Windows_Drv" / 385.3GBs Free / 476.3GBs Total ]
