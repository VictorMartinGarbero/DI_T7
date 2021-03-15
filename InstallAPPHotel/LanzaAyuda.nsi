;NSIS Modern User Interface
;Basic Example Script
;Written by Victor Martin

;--------------------------------
;Include Modern UI

!include "MUI2.nsh"
;!include "ZipDLL.nsh"

;--------------------------------
;General

Var StartMenuFolder

;Name and file
Name "APPHotel"
OutFile "InstallAPPHotel.exe"
Unicode True

;Default installation folder
InstallDir "$LOCALAPPDATA\InstallAppHotel"

;Get installation folder from registry if available
InstallDirRegKey HKCU "Software\InstallAppHotel" ""

;Request application privileges for Windows Vista
RequestExecutionLevel user

;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "logoHotel.bmp" ; optional
!define !define MUI_HEADERIMAGE_RIGHT
!define MUI_ABORTWARNING

;--------------------------------
;Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "licencia.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

 ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\InstallAppHotel" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Function CallbackTest
  Pop $R8
  Pop $R9

  SetDetailsPrint textonly
  DetailPrint "Extracting $R8 / $R9..."
  SetDetailsPrint both
FunctionEnd

Section "Install APP Hotel" SecDummy



;ADD YOUR OWN FILES HERE...
SetOutPath "$INSTDIR"
SetCompress off
DetailPrint "Extracting package..."
SetDetailsPrint listonly
File InstallAPPHotel.7z
SetCompress auto
;!insertmacro ZIPDLL_EXTRACT "$INSTDIR\InstallAPPHotel.zip" "$INSTDIR" "<ALL>"

SetDetailsPrint both
;Store installation folder
WriteRegStr HKCU "Software\LanzaAyuda" "" $INSTDIR

;Create uninstaller
WriteUninstaller "$INSTDIR\Uninstall.exe"

GetFunctionAddress $R9 CallbackTest
  Nsis7z::ExtractWithCallback "$INSTDIR\InstallAPPHotel.7z" $R9

  Delete "$OUTDIR\InstallAPPHotel.7z"
SectionEnd

;--------------------------------
;Descriptions

;Language strings
LangString DESC_SecDummy ${LANG_SPANISH} "A test section."

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

;ADD YOUR OWN FILES HERE...

Delete "$INSTDIR\Uninstall.exe"

RMDir "$INSTDIR"

 !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"

DeleteRegKey /ifempty HKCU "Software\InstallAppHotel"

SectionEnd