'+-----------------------------------------------------------------------------+
'| CHC v0.2 * Choking coil sizing application                                  |
'| Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>                   |
'| mkshortcut.vbs                                                              |
'| Make shortcut                                                               |
'+-----------------------------------------------------------------------------+

set WshShell = WScript.CreateObject("WScript.Shell" )
set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")
oShellLink.TargetPath = Wscript.Arguments.Named("target")
oShellLink.WindowStyle = 1
oShellLink.Save

