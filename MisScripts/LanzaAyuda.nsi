;NSIS Modern User Interface
;Basic Example Script
;Written by Victor Martin

;--------------------------------
;Include Modern UI

!include "MUI2.nsh"

;----------------
;Variable

Var LanzaAyuda.jar

;--------------------------------
;General

;Name and file
Name "LanzaAyuda"
OutFile "InstallAyuda.exe"
Unicode True

;Default installation folder
InstallDir "$LOCALAPPDATA\LanzaAyuda.jar"

;Get installation folder from registry if available
InstallDirRegKey HKCU "Software\LanzaAyuda.jar" ""

;Request application privileges for Windows Vista
RequestExecutionLevel user

;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "IESMontecillos.bmp" ; optional
!define !define MUI_HEADERIMAGE_RIGHT
!define MUI_ABORTWARNING

;--------------------------------
;Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

SetOutPath "$INSTDIR"

;ADD YOUR OWN FILES HERE...

;Store installation folder
WriteRegStr HKCU "Software\Modern UI Test" "" $INSTDIR

;Create uninstaller
WriteUninstaller "$INSTDIR\Uninstall.exe"

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

DeleteRegKey /ifempty HKCU "Software\Modern UI Test"

SectionEnd